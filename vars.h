#pragma once
#include <sqlite3.h>
#include <string>

#include"mail++/mail++.h"
#include"env.h"

const std::string DATABASE_PATH="test.db";
inline sqlite3* db;
inline sqlite3_stmt* stmt;

env_loader env_data;
mailpp mail;