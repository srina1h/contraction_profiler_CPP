// Read contractions from a CSV file in the format:
// Dimension_A, Dimension_B, Dimension_C, Contraction_indices, Einstein_notation, data_type, label (ignore this)
// Now create variables in C++ allocating memory for each of these tensor contractions

#include <iostream>
#include <fstream>
#include <string>
#include <vector>
#include <map>
#include <algorithm>
#include <sstream>
#include <unordered_map>
#include <chrono>

#include "contraction.cuh"

using namespace std;
using namespace std::chrono;

struct Dimensions
{
    vector<int64_t> Dimension_A_extents;
    vector<int64_t> Dimension_B_extents;
    vector<int64_t> Dimension_C_extents;
    string Contraction_indices;
    string Einstein_notation;
    string data_type;
    vector<vector<char>> modes;
    unordered_map<char, int64_t> extents;
};

class ContractionCreator
{
public:
    ContractionCreator(const string &filePath) : filePath(filePath) {}

    vector<Dimensions> readCsvFile()
    {
        vector<Dimensions> dimensionsList;
        ifstream file(filePath);
        if (!file.is_open())
        {
            cerr << "Error opening CSV file" << endl;
            return dimensionsList;
        }

        string line;
        // the first line contains the headers
        // add all the headers into another vector
        vector<string> headers;
        getline(file, line);
        stringstream ss(line);
        string item;
        while (getline(ss, item, ','))
        {
            headers.push_back(item);
        }

        while (getline(file, line))
        {
            stringstream ss(line);
            string item;
            Dimensions dim;

            // Now in each line there are strings separated by commas, but each string may contain commas
            // So we need to parse the string properly
            vector<string> tokens;
            bool inQuotes = false;
            string token;
            for (char ch : line)
            {
                if (ch == '\"')
                {
                    inQuotes = !inQuotes;
                }
                else if (ch == ',' && !inQuotes)
                {
                    tokens.push_back(token);
                    token.clear();
                }
                else
                {
                    token += ch;
                }
            }
            tokens.push_back(token); // add the last token

            dim.Dimension_A_extents = parseDimension(tokens[0]);
            dim.Dimension_B_extents = parseDimension(tokens[1]);
            dim.Dimension_C_extents = parseDimension(tokens[2]);

            dim.Contraction_indices = tokens[3];
            dim.Einstein_notation = format_einstein_notation(tokens[4]);
            dim.data_type = tokens[5];
            dim.modes = set_modes(tokens[4]);
            dim.extents = set_extents(dim.Dimension_A_extents, dim.Dimension_B_extents, dim.Dimension_C_extents, dim.modes[0], dim.modes[1], dim.modes[2]);

            // Skip the label
            dimensionsList.push_back(dim);
        }

        file.close();
        return dimensionsList;
    }

    vector<vector<char>> set_modes(string con_type)
    {
        // Remove all spaces from the string
        con_type.erase(remove(con_type.begin(), con_type.end(), ' '), con_type.end());

        string AB = con_type.substr(0, con_type.find("->"));
        string A = AB.substr(0, AB.find("*"));
        string B = AB.substr(AB.find("*") + 1);
        string C = con_type.substr(con_type.find("->") + 2);

        vector<char> mode_a = split_to_chars(A);
        vector<char> mode_b = split_to_chars(B);
        vector<char> mode_c = split_to_chars(C);

        vector<vector<char>> modes;
        modes.push_back(mode_a);
        modes.push_back(mode_b);
        modes.push_back(mode_c);

        return modes;
    }

    vector<char> split_to_chars(const string &str)
    {
        vector<char> chars;
        for (char ch : str)
        {
            chars.push_back(ch);
        }
        return chars;
    }

    unordered_map<char, int64_t> populate_extent(const vector<char> &mode, const vector<int64_t> &dim)
    {
        unordered_map<char, int64_t> extent;
        for (size_t i = 0; i < mode.size(); ++i)
        {
            extent[mode[i]] = dim[i];
        }
        return extent;
    }

    unordered_map<char, int64_t> set_extents(const vector<int64_t> &adim, const vector<int64_t> &bdim, const vector<int64_t> &cdim, const vector<char> &mode_a, const vector<char> &mode_b, const vector<char> &mode_c)
    {
        unordered_map<char, int64_t> extent_a = populate_extent(mode_a, adim);
        unordered_map<char, int64_t> extent_b = populate_extent(mode_b, bdim);
        unordered_map<char, int64_t> extent_c = populate_extent(mode_c, cdim);

        // combine the extents into a final dictionary and return
        unordered_map<char, int64_t> final_extent = extent_a;
        for (const auto &[key, value] : extent_b)
        {
            final_extent[key] = value;
        }
        for (const auto &[key, value] : extent_c)
        {
            final_extent[key] = value;
        }
        return final_extent;
    }

    vector<vector<vector<double>>> runContraction(vector<Dimensions> &dimensionsList)
    {
        vector<vector<vector<double>>> times;

        for (const auto &dim : dimensionsList)
        {
            cout << "Dimension_A: ";
            for (const auto &val : dim.Dimension_A_extents)
                cout << val << " ";
            cout << endl;

            cout << "Dimension_B: ";
            for (const auto &val : dim.Dimension_B_extents)
                cout << val << " ";
            cout << endl;

            cout << "Dimension_C: ";
            for (const auto &val : dim.Dimension_C_extents)
                cout << val << " ";
            cout << endl;

            cout << "Contraction_indices: " << dim.Contraction_indices << endl;
            cout << "Einstein_notation: " << dim.Einstein_notation << endl;
            cout << "data_type: " << dim.data_type << endl;
            cout << "Modes: ";
            for (const auto &mode : dim.modes)
            {
                for (const auto &val : mode)
                    cout << val << " ";
            }
            cout << "Extents: ";
            for (const auto &[key, value] : dim.extents)
            {
                cout << key << " : " << value << " ";
            }
            cout << endl;

            vector<vector<double>> time;
            time = run(dim.modes[0], dim.modes[1], dim.modes[2], dim.extents, CUTENSOR_R_16F);
            times.push_back(time);
        }
        return times;
    }

    void writeCsvFileWithTime(vector<Dimensions> &dimensionsList, string &outputFilePath, vector<vector<vector<double>>> &times)
    {
        ofstream file(outputFilePath);
        if (!file.is_open())
        {
            cerr << "Error opening output CSV file" << endl;
            return;
        }

        file << "dim_A, dim_B, dim_C, contraction_indices, einstein_notation, data_type, default, default_flops, gett, gett_flops, tgett, tgett_flops, ttgt, ttgt_flops, defpat, defpat_flops\n";

        for (size_t i = 0; i < dimensionsList.size(); ++i)
        {
            const auto &dim = dimensionsList[i];
            const auto &time = times[i];

            file << formatDimension(dim.Dimension_A_extents) << ","
                 << formatDimension(dim.Dimension_B_extents) << ","
                 << formatDimension(dim.Dimension_C_extents) << ","
                 << "\"" << dim.Contraction_indices << "\"" << ","
                 << "\"" << dim.Einstein_notation << "\"" << ","
                 << dim.data_type << ","
                 << time[0][0] << ","   // default
                 << time[0][1] << ","   // default flops
                 << time[1][0] << ","   // gett
                 << time[1][1] << ","   // gett flops
                 << time[2][0] << ","   // tgett
                 << time[2][1] << ","   // tgett flops
                 << time[3][0] << ","   // ttgt
                 << time[3][1] << ","   // ttgt flops
                 << time[4][0] << ","   // defpat
                 << time[4][1] << endl; // defpat flops
        }

        file.close();
    }

    string formatDimension(const vector<int64_t> &dim)
    {
        string str = "\"(";
        for (size_t i = 0; i < dim.size(); ++i)
        {
            str += to_string(dim[i]);
            if (i != dim.size() - 1)
                str += ",";
        }
        str += ")\"";
        return str;
    }

    // create a function to get a string as argument, first remove all spaces from it, then replace the * in the string with a comma

    string format_einstein_notation(string str)
    {
        str.erase(remove(str.begin(), str.end(), ' '), str.end());
        replace(str.begin(), str.end(), '*', ',');
        return str;
    }

private:
    string filePath;

    vector<int64_t> parseDimension(const string &dimension)
    {
        cout << dimension << endl;
        vector<int64_t> extents;
        string cleaned = dimension.substr(1, dimension.size() - 2);
        cout << cleaned << endl;
        stringstream ss(cleaned);
        string item;
        while (getline(ss, item, ','))
        {
            // convert item to int64_t
            extents.push_back((int64_t)stoi(item));
        }
        return extents;
    }
};

int main(int argc, char *argv[])
{
    ContractionCreator creator(argv[1]);
    vector<Dimensions> dimensionsList = creator.readCsvFile();

    vector<vector<vector<double>>> times;

    auto start = high_resolution_clock::now();
    times = creator.runContraction(dimensionsList);
    auto end = high_resolution_clock::now();
    auto duration = duration_cast<seconds>(stop - start);
    cout << "Time taken for contractions: " << duration.count() << " seconds" << endl;

    string outputFilePath;
    if (argc < 3)
    {
        outputFilePath = "output.csv";
    }
    else
    {
        outputFilePath = (string)argv[2];
    }
    auto start = high_resolution_clock::now();
    creator.writeCsvFileWithTime(dimensionsList, outputFilePath, times);
    auto end = high_resolution_clock::now();
    auto duration = duration_cast<seconds>(end - start);
    cout << "Time taken for file writing: " << duration.count() << " seconds" << endl;
    return 0;
}