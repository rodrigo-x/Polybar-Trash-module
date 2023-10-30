#!/usr/bin/env bash

# Info about Trash
get_trash_info() {
    local trash_path="$HOME/.local/share/Trash/files"
    local trash_files=($(find "$trash_path" -type f))
    local trash_count="${#trash_files[@]}"
    local trash_size=$(du -sh "$trash_path" | awk '{print $1}')
    local trash_effective_size=$(du -s "$trash_path" | awk '{print $1}')
    echo "$trash_count $trash_size $trash_effective_size"
}

# Status Trash
display_trash_status() {
    local limit=5000000
    local trash_info=($(get_trash_info))
    local trash_count=${trash_info[0]}
    local trash_size=${trash_info[1]}
    local trash_effective_size=${trash_info[2]

    if [[ $trash_effective_size -gt $limit ]]; then
        echo "%{F#ff5770}%{F#f2f2f2}Muito cheia %{F#77f2f2f2}$trash_size"
    elif [[ $trash_count -gt 0 ]]; then
        echo "%{F#FF8B42} %{F#f2f2f2}Cheia %{F#77f2f2f2}$trash_size"
    else
        echo "%{F#5DC0FE}%{F#f2f2f2}Vazia %{F#77f2f2f2}"
    fi
}

display_trash_status
