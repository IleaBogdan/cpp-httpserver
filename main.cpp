#include <crow.h>
#include <random>

int main() {
    crow::SimpleApp app;
    
    CROW_ROUTE(app, "/random")([](){
        std::random_device rd;
        std::mt19937 gen(rd());
        std::uniform_int_distribution<> dis(1, 100);
        
        return std::to_string(dis(gen));
    });
    
    app.port(1337).multithreaded().run();
    return 0;
}