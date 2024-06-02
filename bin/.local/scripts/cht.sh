#usr/bin/env bash

# curl cht.sh/{language}/{query+string}
# curl cht.sh/{core-utill}~{opperation}

languages=`echo "powershell csharp rust python javascript go typescript nodejs lua" | tr ' ' '\n'`
core_utill=`echo "rm ls grep ag xargs find mv sed awk" | tr ' ' '\n'`

selected=` printf "$languages\n$core_utill" | fzf `
read -p "Query: " query

if printf "$languages" | grep -qs $selected; then
    tmux neww bash -c "curl cht.sh/$selected/`echo "$query" | tr ' ' '+'`& while [ : ]; do sleep 1; done"
else 
    tmux neww bash -c "curl cht.sh/$selected~`echo "$query" | tr ' ' '+' | less`& while [ : ]; do sleep 1; done"
fi
