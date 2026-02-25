# -----------------------------
# 기본 옵션
# -----------------------------
export EDITOR=vim
export LANG=ko_KR.UTF-8

# 히스토리
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history
setopt SHARE_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt AUTO_CD
setopt CORRECT

# -----------------------------
# 경로
# -----------------------------
export PATH="/opt/homebrew/bin:$PATH"
export PATH="$HOME/bin:$PATH"

# -----------------------------
# 색상 활성화
# -----------------------------
autoload -U colors && colors

# -----------------------------
# 프롬프트 (가볍고 팬시)
# -----------------------------
setopt PROMPT_SUBST

git_branch() {
  git rev-parse --abbrev-ref HEAD 2>/dev/null
}

PROMPT='%F{cyan}%n@%m%f %F{yellow}%~%f $(git_branch && echo "%F{green}($(git_branch))%f") 
%F{magenta}➜%f '

# -----------------------------
# 자동완성
# -----------------------------

# 메뉴 선택 모드 활성화
zstyle ':completion:*' menu select
autoload -Uz compinit
compinit

# -----------------------------
# 플러그인 (brew 설치 기준)
# -----------------------------
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# -----------------------------
# fzf
# -----------------------------
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# -----------------------------
# alias
# -----------------------------
alias ll='ls -alF'
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias cdkd='cdk diff'
alias cdks='cdk synth'

# -----------------------------
# Node / nvm
# -----------------------------
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# -----------------------------
# Git 기본 단축
# -----------------------------
alias g='git'
alias gs='git status -sb'
alias ga='git add'
alias gaa='git add .'
alias gc='git commit -v'
alias gcm='git commit -m'
alias gp='git push'
alias gpl='git pull'
alias gl='git log --oneline --graph --decorate --all'
alias gd='git diff'
alias gds='git diff --staged'

# -----------------------------
# 브랜치
# -----------------------------
alias gb='git branch'
alias gbd='git branch -d'
alias gbD='git branch -D'
alias gco='git checkout'
alias gcb='git checkout -b'
alias gsw='git switch'
alias gswc='git switch -c'

# -----------------------------
# 리베이스 / 머지
# -----------------------------
alias gr='git rebase'
alias gri='git rebase -i'
alias gm='git merge'

# -----------------------------
# 스태시
# -----------------------------
alias gst='git stash'
alias gstp='git stash pop'
alias gstl='git stash list'

# -----------------------------
# 원격
# -----------------------------
alias grv='git remote -v'

# -----------------------------
# 복구 (안전)
# -----------------------------
alias gundo='git reset --soft HEAD~1'
alias ghard='git reset --hard'

alias glg='git log --graph --pretty=format:"%C(yellow)%h%Creset - %C(cyan)%an%Creset - %C(green)%cr%Creset - %s" --abbrev-commit'

export PATH="$HOME/.local/bin:$PATH"
eval "$(starship init zsh)"



