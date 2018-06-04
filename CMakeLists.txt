cmake_minimum_required(VERSION 3.10)
project(EP2 C)
set(CMAKE_C_STANDARD 99)
add_executable(EP2 main.cu structure.cu structure.h reduction.cu reduction.h)