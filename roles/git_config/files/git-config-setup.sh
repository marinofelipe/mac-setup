#!/bin/bash

Reference: https://gist.github.com/unnamedd/2794781

Git Configuration
Useful configuration options for Git on macOS

Global ignore file:
echo ".DS_Store" >> ~/.gitignore
git config --global core.excludesfile ~/.gitignore

Default Branch name
git config --global init.defaultBranch main

Git aliases and their documentation comments:
git config --global alias.st status -sb
git config --global alias-doc.st 'Displays the status of your workspace and staging area'

git config --global alias.cm commit
git config --global alias-doc.cm 'Commits your staged changes'

git config --global alias.co checkout
git config --global alias-doc.co 'Switches branches or restores workspace files'

git config --global alias.br branch
git config --global alias-doc.br 'Manages branches'

git config --global alias.remotes remote -v
git config --global alias-doc.remotes 'Displays the list of remote repositories and their URLs'

git config --global alias.branches branch -v
git config --global alias-doc.branches 'Displays all branches with their last commit messages'

git config --global alias.aliases "!/opt/homebrew/bin/bash ~/.scripts/git-aliases.sh"
git config --global alias-doc.aliases 'Displays all configured aliases alongside their explanation'

git config --global alias.wipe "reset HEAD --hard"
git config --global alias-doc.wipe 'Resets workspace and index to the last commit, hardly discarding all changes'

git config --global alias.rollback "!f() { git reset HEAD~\"$1\"; }; f"
git config --global alias-doc.rollback 'Undo the last N commits retaining their changes in the workspace and index'

git config --global alias.unstage "reset HEAD --"
git config --global alias-doc.unstage 'Unstage files from the staging area, keeping their changes'

git config --global alias.discard "checkout --"
git config --global alias-doc.discard 'Discards changes in the workspace'

git config --global alias.redo "commit --amend --no-edit"
git config --global alias-doc.redo 'Amends the last commit without altering the commit message'

git config --global alias.clean "remote prune origin"
git config --global alias-doc.clean 'Clean up stale references to non-existent remote branches'

git config --global alias.p "!git push -u $1 origin $(git rev-parse --abbrev-ref HEAD)"
git config --global alias-doc.p 'Pushes the current branch to the origin remote. Optionally pass params such as `-f`'

git config --global alias.gi '!gi() { curl -L -s https://www.gitignore.io/api/$@; }; gi'
git config --global alias-doc.gi 'Fetches .gitignore templates from gitignore.io based on specified parameters'

git config --global alias.history "log --oneline --graph"
git config --global alias-doc.history 'Displays the commit history as a graph with one line per commit'

git config --global alias.logs "log --show-signature"
git config --global alias-doc.logs 'Displays the commit history with GPG signature verification'

git config --global alias.lazy "! onefetch"
git config --global alias-doc.lazy 'Runs lazygit, a terminal UI for git commands'

git config --global alias.summary "! lazygit"
git config --global alias-doc.summary 'Summarizes repository statistics and information'

Prefer ssh over http
git config --global url."git@github.com:".insteadOf "https://github.com/"

Information about the author/commiter:
For Personal Repositories
git config --global user.name "Felipe Marino"
git config --global user.email felipemarino91@gmail.com
git config --global user.signingkey CD1B6C70016B3BD91C38BC49F94B6756E6B6D57A

Colorized output:
git config --global color.ui true
git config --global color.diff auto
git config --global color.interactive auto
git config --global color.branch auto

git config --global color.status auto
git config --global color.status.changed "red normal"
git config --global color.status.untracked "blue normal"
git config --global color.status.added "magenta normal"
git config --global color.status.updated "green normal"
git config --global color.status.branch "yellow normal bold"
git config --global color.status.header "white normal bold"

Zed as the default editor:
git config --global core.editor "zed"

Signing commits
git config --global commit.gpgsign true
git config --global gpg.format ssh
git config --global gpg.ssh.allowedSignersFile ~/.ssh/allowed_signers
It expects such ssh key on the given path
git config --global user.signingkey ~/.ssh/id_rsa.pub

Change the font in gitk: Open ~/.gitk and add:
set mainfont {Monaco 12}
set textfont {Monaco 12}
set uifont {Monaco 12}

Delta Settings

git config --global color.branch auto
git config --global core.pager delta
git config --global interactive.diffFilter delta --color-only
git config --global delta.navigate true
git config --global merge.conflictstyle diff3
git config --global diff.colorMoved default

Tags
git config --global tag.sort version:refname

Branches
git config --global column.ui auto
git config --global branch.sort -committerdate

Push
git config --global push.autoSetupRemote true
git config --global push.followTags true

Fetch
git config --global fetch.prune true
git config --global fetch.pruneTags true

Help
git config --global help.autocorrect prompt
git config --global fetch.all true
