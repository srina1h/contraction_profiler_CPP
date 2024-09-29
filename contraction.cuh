#include <cuda_runtime.h>
#include <unordered_map>
#include <vector>
#include <stdio.h>

namespace contraction
{
    void run(std::vector<char> modeC, std::vector<char> modeA, std::vector<char> modeB, std::unordered_map<char, int64_t> extent);
}