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

using namespace std;

struct Dimensions
{
    vector<int> Dimension_A_extents;
    vector<int> Dimension_B_extents;
    vector<int> Dimension_C_extents;
    string Contraction_indices;
    string Einstein_notation;
    string data_type;
    vector<vector<char> > modes;
    unordered_map<char, int> extents;
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

    vector<vector<char> > set_modes(string con_type)
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

        vector<vector<char> > modes;
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

    unordered_map<char, int> populate_extent(const vector<char> &mode, const vector<int> &dim)
    {
        unordered_map<char, int> extent;
        for (size_t i = 0; i < mode.size(); ++i)
        {
            extent[mode[i]] = dim[i];
        }
        return extent;
    }

    unordered_map<char, int> set_extents(const vector<int> &adim, const vector<int> &bdim, const vector<int> &cdim, const vector<char> &mode_a, const vector<char> &mode_b, const vector<char> &mode_c)
    {
        unordered_map<char, int> extent_a = populate_extent(mode_a, adim);
        unordered_map<char, int> extent_b = populate_extent(mode_b, bdim);
        unordered_map<char, int> extent_c = populate_extent(mode_c, cdim);

        // combine the extents into a final dictionary and return
        unordered_map<char, int> final_extent = extent_a;
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

    void createContractionVariables(const vector<Dimensions> &dimensionsList)
    {
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
        }
    }

    //create a function to get a string as argument, first remove all spaces from it, then replace the * in the string with a comma

    string format_einstein_notation(string str)
    {
        str.erase(remove(str.begin(), str.end(), ' '), str.end());
        replace(str.begin(), str.end(), '*', ',');
        return str;
    }

private:
    string filePath;

    vector<int> parseDimension(const string &dimension)
    {
        cout << dimension << endl;
        vector<int> extents;
        string cleaned = dimension.substr(1, dimension.size() - 2);
        cout << cleaned << endl;
        stringstream ss(cleaned);
        string item;
        while (getline(ss, item, ','))
        {
            extents.push_back(stoi(item));
        }
        return extents;
    }
};

int main(int argc, char **argv)
{
    ContractionCreator creator("/Users/srinath/Documents/GitHub/contraction_profiler_CPP/high_dim_con.csv");
    vector<Dimensions> dimensionsList = creator.readCsvFile();
    creator.createContractionVariables(dimensionsList);
    return 0;
}