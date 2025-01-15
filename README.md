# FC2T/L
An expansion library for building your own C++ (or Rust) extensions of FC2.\
This gives you unparalleled access to the lua_State allowing you to create custom libraries. 

* Rust may not need these due to cargos already having them. [ex: mlua]
* You are responsible for what you load into your Lua environment, please check with end-users of the authenticity of unknown binaries

## Getting Started
For Windows you will need a visual studio runtime, specifically those from Visual Studio Community.\
When building simply run either `windows.bat` or `linux.sh` to create your own FC2L library.

## Early Development
FC2T/L was discovered as an unintended library loader in FC2 that has now become a feature.\
Features from FC2T are being viewed for compatibility, so don't expect it to run FC2T headers (yet).

More to be done. - WholeCream