languages="
bash
c
cpp
css
gdb
golang
html
javascript
lua
nodejs
python
tmux
typescript
zsh
"

commands="
awk
cargo
cat
chmod
chown
cp
cp
docker
docker-compose
find
fzf
git
git-commit
git-rebase
git-status
git-worktree
grep
head
jq
kill
less
ls
lsof
make
man
mv
ps
rename
rg
rm
sed
ssh
stow
tail
tar
tldr
tr
xargs
"

selected=`echo $languages $commands | tr ' ' '\n' | fzf`
if [[ -z $selected ]]; then
    exit 0
fi

read -p "Enter Query: " query
query=`echo $query | tr ' ' '+'`

if echo "$languages" | grep -qs "$selected"; then
    tmux neww bash -c "curl -s cht.sh/$selected/$query | less"
else
    tmux neww bash -c "curl -s cht.sh/$selected~$query | less"
fi
