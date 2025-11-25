#!/usr/bin/env zsh

# Reference: https://gist.github.com/unnamedd/2794781

# Define colors
alias_color='\033[1;34m'   # Bold blue
comment_color='\033[0;32m' # Green
no_color='\033[0m'         # Reset color

printf "\nGit Aliases\n"

alignment_spaces=12

declare -A comments_map

########################################
# 1. Extract comments from [alias-doc] #
########################################
awk '
BEGIN { in_alias_doc = 0; }
/^\[alias-doc\]/ { in_alias_doc = 1; next; }
/^\[/ { in_alias_doc = 0; }
in_alias_doc { print; }
' ~/.gitconfig |
while read -r line; do
  if [[ "$line" =~ ^[[:space:]]*([^=[:space:]]+)[[:space:]]*=[[:space:]]*(.*)$ ]]; then
    key="${BASH_REMATCH[1]}"
    val="${BASH_REMATCH[2]}"
    comments_map["$key"]="$val"
  fi
done

###################################
# 2. Extract aliases from [alias] #
###################################
awk '
BEGIN { in_alias = 0; }
/^\[alias\]/ { in_alias = 1; next; }
/^\[/ { in_alias = 0; }
in_alias { print; }
' ~/.gitconfig |
while read -r line; do
  # Skip empty lines or comments
  [[ -z "$line" || "$line" =~ ^# ]] && continue

  # Parse alias line
  if [[ "$line" =~ ^[[:space:]]*([^=[:space:]]+)[[:space:]]*=[[:space:]]*(.*)$ ]]; then
    alias_name="${BASH_REMATCH[1]}"
    alias_cmd="${BASH_REMATCH[2]}"

    # Look up matching comment in alias-doc map
    comment="${comments_map[$alias_name]}"

    # Padding
    alias_length=${#alias_name}
    spaces_needed=$((alignment_spaces - alias_length))
    spaces=$(printf "%${spaces_needed}s")

    # Print alias + comment
    printf "${alias_color}%s${no_color}${spaces}${comment_color}%s${no_color}\n" \
           "$alias_name" "$comment"
  fi
done
