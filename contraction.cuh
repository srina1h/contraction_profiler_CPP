#include <cuda_runtime.h>
#include <unordered_map>
#include <vector>
#include <stdio.h>

namespace contraction
{
    void run(std::vector<int> modeC, std::vector<int> modeA, std::vector<int> modeB, std::unordered_map<int, int64_t> extent, std::vector<int64_t>);
}