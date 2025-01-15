#include "fc2sample.h"
#include "fc2l/fc2l.hpp"

int my_function(lua_State* L) {
    double num1 = luaL_checknumber(L, 1);
    double num2 = luaL_checknumber(L, 2);
    lua_pushnumber(L, num1 + num2);
    return 1;
}

static const luaL_Reg mylib[] = {
    {"add", my_function},
    {NULL, NULL}
};

using namespace std;

extern "C" __declspec(dllexport) int luaopen_fc2sample(lua_State* L)
{
    luaL_register(L, "fc2sample", mylib);
    return 0;
}