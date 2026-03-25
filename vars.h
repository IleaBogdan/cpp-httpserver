#pragma once
#include <sqlite3.h>
#include <string>

const std::string DATABASE_PATH="test.db";
inline sqlite3* db;
inline sqlite3_stmt* stmt;