#include <bits/stdc++.h>
using namespace std;

int main() {
    int x=50, c=0;
    string ip;

    while(cin>> ip) {
        int n=stoi(ip.substr(1));
        int n1=n/100;
        int n2=n%100;

        c+=n1;

        int dir = (ip[0] == 'R')*2-1;
        int zero = (x == 0);
        int oldx = x;

        x = zero*((dir == 1)*n2 + (dir == -1)*(100 - n2)) + (1-zero)*(x+dir*n2);

        int crossed = (1 - zero)*((x>100) + (x<0));

        x = (x%100 + 100)%100;

        c+=crossed;
        c+=(x == 0);
    }

    cout<< "value: "<< c<< endl;
    return 0;
}

// #include <bits/stdc++.h>
// using namespace std;

// int main() {
//     int x=50, c=0;
//     string ip;

//     while(cin>> ip) {
//         int n=stoi(ip.substr(1));
//         int n1=n/100;
//         int n2=n%100;
//         c+=n1;
//         if(!x) {
//             if(ip[0]=='R') x=n2;
//             else {
//                 x=-n2+100;
//             }
//         }
//         else {
//             if(ip[0]=='R') {
//                 x+=n2;
//                 if(x>99) {
//                     if(x!=100) c++;
//                     x%=100;
//                 }
//             }
//             else {
//                 x-=n2;
//                 if(x<0) {
//                     c++;
//                     x+=100;
//                 }
//             }
//         }
//         if(!x) {
//             c++;
//         }
//         cout<< x<< endl;
//     }

//     cout<< endl<< "value: "<< c<< endl;
//     return 0;
// }