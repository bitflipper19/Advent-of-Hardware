#include <bits/stdc++.h>
using namespace std;

/*
This script reads the ip.txt file and converts it into the appropriate format 
for the verilog testbench. Copy-paste the generated "tb.txt" into /verilog/day1p1_tb.v
at the appropriate place.

This file singly handles the test bench formatting for both test benches
comment-uncomment the required lines, 
1. n=-n and fout<< "send("<< n<< ");"<< endl; for part 1
2. d=0 and fout<< "send("<< d<< ", "<< n<< ");"<< endl; for part 2
*/

int main() {
    ifstream fin("ip.txt"); // testip.txt for the given test case
    ofstream fout("tb.txt");

    string s;
    while(fin>> s) {
        char dir=s[0];
        int n=stoi(s.substr(1));
        int d=1;
        if(dir=='L')
            // n=-n;
            d=0;

        // fout<< "send("<< n<< ");"<< endl;
        fout<< "send("<< d<< ", "<< n<< ");"<< endl;
    }

    fin.close();
    fout.close();
    return 0;
}
