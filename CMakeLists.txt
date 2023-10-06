cmake_minimum_required(VERSION 3.12)
project(Calculator)

# 设置 Flex 和 Bison 文件的输入和输出
set(FLEX_FILE ${CMAKE_SOURCE_DIR}/src/lexer.l)
set(BISON_FILE ${CMAKE_SOURCE_DIR}/src/parser.y)
set(LEXER_CPP ${CMAKE_CURRENT_BINARY_DIR}/lexer.yy.c)
set(PARSER_CPP ${CMAKE_CURRENT_BINARY_DIR}/parser.tab.c)
set(PARSER_HPP ${CMAKE_CURRENT_BINARY_DIR}/parser.tab.h)

# 添加 Flex 和 Bison 的自定义命令
find_package(FLEX REQUIRED)
find_package(BISON REQUIRED)

flex_target(Lexer ${FLEX_FILE} ${LEXER_CPP})
bison_target(Parser ${BISON_FILE} ${PARSER_CPP} DEFINES_FILE ${PARSER_HPP})

# 添加可执行文件并链接 Flex 和 Bison 生成的代码
add_executable(${PROJECT_NAME} ${LEXER_CPP} ${PARSER_CPP})

# 包含生成的头文件目录
target_include_directories(${PROJECT_NAME} PRIVATE ${CMAKE_CURRENT_BINARY_DIR})

# 链接 Flex 和 Bison 库
target_link_libraries(${PROJECT_NAME} PRIVATE ${FLEX_LIBRARIES} ${BISON_LIBRARIES})