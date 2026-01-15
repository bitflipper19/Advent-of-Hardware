#include <bits/stdc++.h>
using namespace std;

/*
Cpp solution of Day 1 Part 1 of Advent of Code 2025
Algorithm:
1. Reads from the input file provided as ip.txt
2. Initial value of x=50 (as specified in the question) and counter=0
3. If the input's first character is 'R' that means go right by the number specified
   i.e. add in x
4. else subtract from x
5. restrict x within 0-99 
6. print the count i.e. c
*/

int main() {
    int x=50, c=0;
    string ip;

    while(cin>> ip) {
        int n=stoi(ip.substr(1));
        if(ip[0]=='L') {
            x=(x-n)%100;
            if(x<0) x+=100;
        }

        else {
            x=(x+n)%100;
        }
        // cout<< x<< endl;
        if(!x) c++;
    }

    cout<< "value: "<< c<< endl;
    return 0;
}
