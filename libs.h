#pragma once

#include <crow.h>
#include <random>
#include <sqlite3.h>
#include <string>
#include <vector>
#include <algorithm>

#include "json.hpp"
using json=nlohmann::json;

const std::string DATABASE_PATH="test.db";
inline sqlite3* db;
inline sqlite3_stmt* stmt;