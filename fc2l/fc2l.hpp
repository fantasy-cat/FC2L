#ifndef FC2L_HPP
#define FC2L_HPP

#if defined(_WIN32) || defined(_WIN64)
    #include "windows/fc2.hpp"
    #include "windows/lua.hpp"
#elif defined(__linux__)
    #include "linux/fc2.hpp"
    #include "linux/lua.hpp"
#else
    #error "Unsupported platform. Only Windows and Linux are supported."
#endif

#endif // FC2L_HPP
