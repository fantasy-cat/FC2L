use mlua::prelude::*;
use mlua::ffi;
use std::ffi::CString;

fn main() {}

#[no_mangle]
pub unsafe extern "C" fn luaopen_fc2rust(L: *mut mlua::ffi::lua_State) -> i32 {
    // Rust > C++? wat

    ffi::lua_pushnil(L);
    ffi::lua_pop(L, 1);

    1
}