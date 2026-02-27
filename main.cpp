#include <crow.h>
#include <random>

std::string get_random_number(){
    std::random_device rd;
    std::mt19937 gen(rd());
    std::uniform_int_distribution<> dis(1, 100);
    
    return std::to_string(dis(gen));
}
int main() {
    crow::SimpleApp app;
    
    // CROW_ROUTE(app, "/openapi.yaml").methods("GET"_method)([](crow::request& req, crow::response& res) {
    //     res.set_static_file_info("static/openapi.yaml");
    //     res.end();
    // });
    
    CROW_ROUTE(app, "/")([](crow::request& req, crow::response& res) {
        res.redirect("/static/swagger/index.html");
        res.end();
    });
    
    CROW_ROUTE(app, "/random").methods("GET"_method)(get_random_number);
    
    app.port(1337).multithreaded().run();
    
    RET_SUCCES:
    return EXIT_SUCCESS;
}