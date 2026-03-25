#include<fstream>
#include"mail++.h"

std::string load_password_from_env(void){
    std::string s;
    std::ifstream fin(".env");
    std::getline(fin,s);
    auto pass=s.substr(s.find(": ")+2,s.size());
    // std::cout<<pass;
    fin.close();
    return pass;
}
signed main(void){
    mailpp m("squadshadow711@gmail.com",load_password_from_env());
    m.send_mail("ilea.bogdan06@gmail.com","hello","merge");
    m.send_mail("ilea.bogdan06@gmail.com","hello again","merge?");
    return 0;
}