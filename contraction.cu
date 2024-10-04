#include <stdlib.h>
#include <stdio.h>
#include <assert.h>

#include <cuda_runtime.h>
#include <cutensor.h>

#include <unordered_map>
#include <vector>
#include "contraction.cuh"

// Handle cuTENSOR errors
#define HANDLE_ERROR(x)                                         \
    {                                                           \
        const auto err = x;                                     \
        if (err != CUTENSOR_STATUS_SUCCESS)                     \
        {                                                       \
            printf("Error: %s\n", cutensorGetErrorString(err)); \
            exit(-1);                                           \
        }                                                       \
    };

#define HANDLE_CUDA_ERROR(x)                                \
    {                                                       \
        const auto err = x;                                 \
        if (err != cudaSuccess)                             \
        {                                                   \
            printf("Error: %s\n", cudaGetErrorString(err)); \
            exit(-1);                                       \
        }                                                   \
    };

std::vector<double> performContraction(std::vector<int> modeC, std::vector<int> modeA, std::vector<int> modeB, std::unordered_map<int, int64_t> extent, cutensorAlgo_t algo, cutensorDataType_t dataType = CUTENSOR_R_16F)
{
    // Host element type definition
    typedef float floatTypeCompute;
    cutensorDataType_t typeA, typeB, typeC;
    size_t elementSize;

    cutensorComputeDescriptor_t descCompute;

    if (dataType == CUTENSOR_R_16F)
    {
        printf("Running with FP16\n");
        typeA = CUTENSOR_R_16F;
        typeB = CUTENSOR_R_16F;
        typeC = CUTENSOR_R_16F;
        elementSize = sizeof(_Float16);

        descCompute = CUTENSOR_COMPUTE_DESC_16F;
    }
    else
    {
        typeA = CUTENSOR_R_32F;
        typeB = CUTENSOR_R_32F;
        typeC = CUTENSOR_R_32F;
        elementSize = sizeof(float);

        descCompute = CUTENSOR_COMPUTE_DESC_32F;
    }

    int nmodeA = modeA.size();
    int nmodeB = modeB.size();
    int nmodeC = modeC.size();

    std::vector<int64_t> extentC;
    for (auto mode : modeC)
        extentC.push_back(extent[mode]);
    std::vector<int64_t> extentA;
    for (auto mode : modeA)
        extentA.push_back(extent[mode]);
    std::vector<int64_t> extentB;
    for (auto mode : modeB)
        extentB.push_back(extent[mode]);

    double gflops = 1;
    for (auto const &x : extent)
    {
        gflops *= x.second;
    }
    gflops = gflops / 1e9;

    size_t elementsA = 1;
    for (auto mode : modeA)
        elementsA *= extent[mode];
    size_t elementsB = 1;
    for (auto mode : modeB)
        elementsB *= extent[mode];
    size_t elementsC = 1;
    for (auto mode : modeC)
        elementsC *= extent[mode];

    size_t sizeA = elementSize * elementsA;
    size_t sizeB = elementSize * elementsB;
    size_t sizeC = elementSize * elementsC;

    void *A_d, *B_d, *C_d;
    cudaMalloc((void **)&A_d, sizeA);
    cudaMalloc((void **)&B_d, sizeB);
    cudaMalloc((void **)&C_d, sizeC);

    void *A = malloc(elementSize * elementsA);
    void *B = malloc(elementSize * elementsB);
    void *C = malloc(elementSize * elementsC);

    // if (dataType == CUTENSOR_R_16F)
    // {
    //     curand_uniform(NULL, (__half *)A_d, elementsA);
    //     curand_uniform(NULL, (__half *)B_d, elementsB);
    //     curand_uniform(NULL, (__half *)C_d, elementsC);
    // }
    // else
    // {
    //     curand_uniform(NULL, (float *)A_d, elementsA);
    //     curand_uniform(NULL, (float *)B_d, elementsB);
    //     curand_uniform(NULL, (float *)C_d, elementsC);
    // }

    if (dataType == CUTENSOR_R_16F)
    {
        for (int64_t i = 0; i < elementsA; i++)
            ((_Float16 *)A)[i] = ((_Float16)rand()) / RAND_MAX;
        for (int64_t i = 0; i < elementsB; i++)
            ((_Float16 *)B)[i] = ((_Float16)rand()) / RAND_MAX;
        for (int64_t i = 0; i < elementsC; i++)
            ((_Float16 *)C)[i] = ((_Float16)rand()) / RAND_MAX;
    }
    else
    {
        for (int64_t i = 0; i < elementsA; i++)
            ((float *)A)[i] = (((float)rand()) / RAND_MAX - 0.5) * 100;
        for (int64_t i = 0; i < elementsB; i++)
            ((float *)B)[i] = (((float)rand()) / RAND_MAX - 0.5) * 100;
        for (int64_t i = 0; i < elementsC; i++)
            ((float *)C)[i] = (((float)rand()) / RAND_MAX - 0.5) * 100;
    }

    HANDLE_CUDA_ERROR(cudaMemcpy(A_d, A, sizeA, cudaMemcpyHostToDevice));
    HANDLE_CUDA_ERROR(cudaMemcpy(B_d, B, sizeB, cudaMemcpyHostToDevice));
    HANDLE_CUDA_ERROR(cudaMemcpy(C_d, C, sizeC, cudaMemcpyHostToDevice));

    const uint32_t kAlignment = 128;
    assert(uintptr_t(A_d) % kAlignment == 0);
    assert(uintptr_t(B_d) % kAlignment == 0);
    assert(uintptr_t(C_d) % kAlignment == 0);

    cutensorHandle_t handle;
    HANDLE_ERROR(cutensorCreate(&handle));

    cutensorTensorDescriptor_t descA;
    HANDLE_ERROR(cutensorCreateTensorDescriptor(handle,
                                                &descA,
                                                nmodeA,
                                                extentA.data(),
                                                NULL,
                                                typeA, kAlignment));

    cutensorTensorDescriptor_t descB;
    HANDLE_ERROR(cutensorCreateTensorDescriptor(handle,
                                                &descB,
                                                nmodeB,
                                                extentB.data(),
                                                NULL,
                                                typeB, kAlignment));

    cutensorTensorDescriptor_t descC;
    HANDLE_ERROR(cutensorCreateTensorDescriptor(handle,
                                                &descC,
                                                nmodeC,
                                                extentC.data(),
                                                NULL,
                                                typeC, kAlignment));

    cutensorOperationDescriptor_t desc;
    HANDLE_ERROR(cutensorCreateContraction(handle,
                                           &desc,
                                           descA, modeA.data(), /* unary operator A*/ CUTENSOR_OP_IDENTITY,
                                           descB, modeB.data(), /* unary operator B*/ CUTENSOR_OP_IDENTITY,
                                           descC, modeC.data(), /* unary operator C*/ CUTENSOR_OP_IDENTITY,
                                           descC, modeC.data(),
                                           descCompute));

    HANDLE_ERROR(cutensorOperationDescriptorSetAttribute(handle,
                                                         &desc,
                                                         CUTENSOR_OPERATION_DESCRIPTOR_SCALAR_TYPE,
                                                         (void *)&dataType,
                                                         sizeof(dataType)));

    cutensorDataType_t scalarType;
    HANDLE_ERROR(cutensorOperationDescriptorGetAttribute(handle,
                                                         desc,
                                                         CUTENSOR_OPERATION_DESCRIPTOR_SCALAR_TYPE,
                                                         (void *)&scalarType,
                                                         sizeof(scalarType)));

    printf("Scalar type: %d\n", scalarType);
    printf("Data type: %d\n", dataType);

    assert(scalarType == dataType);
    floatTypeCompute alpha = (floatTypeCompute)1.0f;
    floatTypeCompute beta = (floatTypeCompute)0.f;

    cutensorPlanPreference_t planPref;
    HANDLE_ERROR(cutensorCreatePlanPreference(
        handle,
        &planPref,
        algo,
        CUTENSOR_JIT_MODE_NONE));

    uint64_t workspaceSizeEstimate = 0;
    const cutensorWorksizePreference_t workspacePref = CUTENSOR_WORKSPACE_DEFAULT;
    HANDLE_ERROR(cutensorEstimateWorkspaceSize(handle,
                                               desc,
                                               planPref,
                                               workspacePref,
                                               &workspaceSizeEstimate));

    cutensorPlan_t plan;
    HANDLE_ERROR(cutensorCreatePlan(handle,
                                    &plan,
                                    desc,
                                    planPref,
                                    workspaceSizeEstimate));

    uint64_t actualWorkspaceSize = 0;
    HANDLE_ERROR(cutensorPlanGetAttribute(handle,
                                          plan,
                                          CUTENSOR_PLAN_REQUIRED_WORKSPACE,
                                          &actualWorkspaceSize,
                                          sizeof(actualWorkspaceSize)));

    assert(actualWorkspaceSize <= workspaceSizeEstimate);

    void *work = nullptr;
    if (actualWorkspaceSize > 0)
    {
        HANDLE_CUDA_ERROR(cudaMalloc(&work, actualWorkspaceSize));
        assert(uintptr_t(work) % 128 == 0);
    }

    cudaStream_t stream;
    HANDLE_CUDA_ERROR(cudaStreamCreate(&stream));

    float timing = 0;

    for (int i = 0; i < 5; i++)
    {
        HANDLE_CUDA_ERROR(cudaMemcpy(C_d, C, sizeC, cudaMemcpyHostToDevice));

        cudaEvent_t start, stop;
        HANDLE_CUDA_ERROR(cudaEventCreate(&start));
        HANDLE_CUDA_ERROR(cudaEventCreate(&stop));
        HANDLE_CUDA_ERROR(cudaEventRecord(start, stream));

        HANDLE_ERROR(cutensorContract(handle,
                                      plan,
                                      (void *)&alpha, A_d, B_d,
                                      (void *)&beta, C_d, C_d,
                                      work, actualWorkspaceSize, stream));

        HANDLE_CUDA_ERROR(cudaEventRecord(stop, stream));
        HANDLE_CUDA_ERROR(cudaEventSynchronize(stop));
        float milliseconds = 0;
        HANDLE_CUDA_ERROR(cudaEventElapsedTime(&milliseconds, start, stop));
        milliseconds /= 1000;
        timing += milliseconds;
    }

    timing /= 5;

    HANDLE_ERROR(cutensorDestroy(handle));
    HANDLE_ERROR(cutensorDestroyPlan(plan));
    HANDLE_ERROR(cutensorDestroyOperationDescriptor(desc));
    HANDLE_ERROR(cutensorDestroyTensorDescriptor(descA));
    HANDLE_ERROR(cutensorDestroyTensorDescriptor(descB));
    HANDLE_ERROR(cutensorDestroyTensorDescriptor(descC));
    HANDLE_CUDA_ERROR(cudaStreamDestroy(stream));

    if (A)
        free(A);
    if (B)
        free(B);
    if (C)
        free(C);
    if (A_d)
        cudaFree(A_d);
    if (B_d)
        cudaFree(B_d);
    if (C_d)
        cudaFree(C_d);
    if (work)
        cudaFree(work);

    printf("Timing: %f s\n", timing);
    printf("GFLOPS: %f\n", gflops / timing);

    std::vector<double> returnVector = {(double)timing, gflops / timing};

    return returnVector;
}

std::vector<std::vector<double>> run(std::vector<char> modeC, std::vector<char> modeA, std::vector<char> modeB, std::unordered_map<char, int64_t> extent, cutensorDataType_t dataType = CUTENSOR_R_16F)
{
    std::vector<int> modeC_int(modeC.begin(), modeC.end());
    std::vector<int> modeA_int(modeA.begin(), modeA.end());
    std::vector<int> modeB_int(modeB.begin(), modeB.end());

    std::unordered_map<int, int64_t> extent_int;
    for (auto const &x : extent)
        extent_int[x.first] = x.second;

    cutensorAlgo_t algo = CUTENSOR_ALGO_DEFAULT;

    std::vector<double> returnVec1, returnVec2, returnVec3, returnVec4, returnVec5;

    returnVec1 = performContraction(modeC_int, modeA_int, modeB_int, extent_int, algo, dataType);
    HANDLE_CUDA_ERROR(cudaDeviceSynchronize());

    algo = CUTENSOR_ALGO_GETT;

    returnVec2 = performContraction(modeC_int, modeA_int, modeB_int, extent_int, algo, dataType);
    HANDLE_CUDA_ERROR(cudaDeviceSynchronize());

    algo = CUTENSOR_ALGO_TGETT;

    returnVec3 = performContraction(modeC_int, modeA_int, modeB_int, extent_int, algo, dataType);
    HANDLE_CUDA_ERROR(cudaDeviceSynchronize());

    algo = CUTENSOR_ALGO_TTGT;

    returnVec4 = performContraction(modeC_int, modeA_int, modeB_int, extent_int, algo, dataType);
    HANDLE_CUDA_ERROR(cudaDeviceSynchronize());

    algo = CUTENSOR_ALGO_DEFAULT_PATIENT;

    returnVec5 = performContraction(modeC_int, modeA_int, modeB_int, extent_int, algo, dataType);
    HANDLE_CUDA_ERROR(cudaDeviceSynchronize());

    std::vector<std::vector<double>> returnVec = {returnVec1, returnVec2, returnVec3, returnVec4, returnVec5};
    return returnVec;
}