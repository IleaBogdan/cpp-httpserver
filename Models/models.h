#pragma once
#include<string>
#include<crow.h>

#include"../main.h"
#include"../vars.h"

namespace M_random{
    void random_number(crow::request& req, crow::response& res);
}

namespace M_db_query{
    void checkName(crow::request& req, crow::response& res);
    void checkUser(crow::request& req, crow::response& res);
}

namespace M_download_file{
    void downloaddatabase(crow::request& req, crow::response& res);
}