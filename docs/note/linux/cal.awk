#!/bin/awk -f
# Marry   2143 78 84 77
# Jack    2321 66 78 45
# Tom     2122 48 77 71
# Mike    2537 87 97 95
# Bob     2415 40 57 62

# 运行前，定义一些变量，打印一些前置文案
BEGIN {
    math = 0
    english = 0
    computer = 0

    printf "Name    No.     Math    English     Computer    Total\n"
    printf "-----------------------------------------------------\n"
}

# 运行中
{
    math += $3
    english += $4
    computer += $5

    printf "%-6s %-6s %4d %8d %8d %8d\n", $1, $2, $3, $4, $5, $3+$4+$5
}

# 运行后
END {
    printf "-----------------------------------------------------\n"
    printf " Total:%10d %8d %8d\n", math, english, computer
    printf "Average:%10.2f %8.2f %8.2f\n", math/NR, english/NR, computer/NR
}