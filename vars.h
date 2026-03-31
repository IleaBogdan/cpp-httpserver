#pragma once
#include <sqlite3.h>
#include <string>

#include"mail++/mail++.h"
#include"env.h"

// note to self and to Luca:
// global vars declared in headers must be const or inline
// global vars references must have the exter keyword (I belive, I am not sure, will check)
// but the extern ones must be declared in a .cpp file

const std::string DATABASE_PATH="test.db";
inline sqlite3* db;
inline sqlite3_stmt* stmt;

inline env_loader env_data;
inline mailpp mail;
