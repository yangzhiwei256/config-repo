## CMake自动化构建工具，用于生成各种makefile文件，方便项目统一编译、执行
## 设置Cmake最低版本号
cmake_minimum_required(VERSION 3.13)

## 指定生成的工程名,隐士定义2个变量：项目名_SOURCE_DIR 和 项目名_BINARY_DIR
## 格式：PROJECT(projectname [CXX] [C] [Java]) ，支持C++/C/Java，缺省支持全部语言
project(CPP_EXPERIENCE)

## 设置C++版本号
## 格式：SET(VAR [VALUE] [CACHE TYPE DOCSTRING [FORCE]])，value存在多个可以用空格隔开，但必须使用双引号包括，或者使用分号分隔
set(CMAKE_CXX_STANDARD 14)

## 作用：用于向终端输出用户定义的信息
## 格式：MESSAGE([SEND_ERROR | STATUS | FATAL_ERROR] "message to display" ...)
## 类型说明：
##   SEND_ERROR，产生错误，生成过程被跳过
##   SATUS： 输出前缀为-的信息
##   FATAL_ERROR，立即终止所有cmake过程
## 构建时打印提示信息
MESSAGE(STATUS "This is BINARY dir -> ${CPP_EXPERIENCE_BINARY_DIR}")
MESSAGE(STATUS "This is SOURCE dir -> ${CPP_EXPERIENCE_SOURCE_DIR}")

## aux_source_directory： 扫描指定路径源文件名，存入变量SRC_DIR
aux_source_directory(./include SRC_DIR)

## 引入头文件
include_directories("${CPP_EXPERIENCE_BINARY_DIR}/include")

## 生成可执行性文件
## 格式：add_executable(可执行性文件名 源文件列表)  案例：cpp_experience.exe
## cmake会自动去当前目录查找headRef.cpp/headRef.c文件，并执行main方法

## 多目录多源文件组织格式
## add_executable(cpp_experience headRef.cpp include/header.cpp)

## 解释：依赖源文件列表使用变量补全
add_executable(cpp_experience headRef.cpp ${SRC_DIR})
