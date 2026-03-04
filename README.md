# honux-cli-config

개인 CLI 환경설정 모음 (macOS / WSL Ubuntu 공용)

## 파일 구성

| 파일 | 설명 |
|---|---|
| `mac_zshrc` | macOS용 zsh 설정 |
| `linux_zshrc` | WSL Ubuntu용 zsh 설정 |
| `nvim-init.lua` | Neovim 0.11+ 설정 (lazy.nvim 기반) |

---

## zsh 설정

### macOS

**의존성 설치 (Homebrew)**
```bash
brew install starship zsh-autosuggestions zsh-syntax-highlighting fzf
```

**적용**
```bash
cp mac_zshrc ~/.zshrc
source ~/.zshrc
```

### WSL Ubuntu

**의존성 설치**
```bash
sudo apt install zsh zsh-autosuggestions zsh-syntax-highlighting fzf

# starship
curl -sS https://starship.rs/install.sh | sh
```

**적용**
```bash
cp linux_zshrc ~/.zshrc
source ~/.zshrc
```

### 주요 기능

- starship 프롬프트 (미설치 시 내장 git branch 표시 프롬프트로 fallback)
- zsh-autosuggestions / zsh-syntax-highlighting
- fzf 통합
- nvm (Node.js 버전 관리)

### Git alias 목록

| alias | 명령 |
|---|---|
| `gs` | `git status -sb` |
| `ga` | `git add` |
| `gaa` | `git add .` |
| `gc` | `git commit -v` |
| `gcm` | `git commit -m` |
| `gp` | `git push` |
| `gpl` | `git pull` |
| `gl` | `git log --oneline --graph --decorate --all` |
| `glg` | 그래프 로그 (날짜/작성자 포함) |
| `gd` / `gds` | `git diff` / `git diff --staged` |
| `gco` / `gcb` | `git checkout` / `git checkout -b` |
| `gsw` / `gswc` | `git switch` / `git switch -c` |
| `gr` / `gri` | `git rebase` / `git rebase -i` |
| `gst` / `gstp` | `git stash` / `git stash pop` |
| `gundo` | `git reset --soft HEAD~1` |

---

## Neovim 설정

Neovim 0.11+ 기준. lazy.nvim을 자동으로 설치하므로 별도 설치 불필요.

**적용**
```bash
mkdir -p ~/.config/nvim
cp nvim-init.lua ~/.config/nvim/init.lua
nvim  # 최초 실행 시 플러그인 자동 설치
```

### 포함된 플러그인

| 플러그인 | 역할 |
|---|---|
| tokyonight.nvim | 테마 |
| lualine.nvim | 상태바 |
| oil.nvim | 파일 탐색 (`-` 키) |
| telescope.nvim | 파일/텍스트 검색 |
| nvim-treesitter | 구문 하이라이트 |
| mason.nvim | LSP 서버 관리 |
| nvim-cmp | 자동완성 |

### 설치되는 LSP 서버

- `ts_ls` — TypeScript / JavaScript
- `lua_ls` — Lua (Neovim 설정용)

추가 LSP는 nvim 내에서 `:MasonInstall <서버명>` 으로 설치.

### 주요 키맵

| 키 | 동작 |
|---|---|
| `<Space>ff` | 파일 찾기 (Telescope) |
| `<Space>fg` | 텍스트 검색 (live grep) |
| `<Space>fb` | 버퍼 목록 |
| `<Space>e` / `-` | 파일 탐색기 (Oil) |
| `<Space>w` / `<Space>q` | 저장 / 종료 |
| `gd` | 정의로 이동 (LSP) |
| `gr` | 참조 보기 (LSP) |
| `K` | 호버 문서 (LSP) |
| `<Space>rn` | 심볼 이름 변경 |
| `<Space>ca` | 코드 액션 |
| `<Space>f` | 포맷 |

### WSL 클립보드

`nvim-init.lua`의 `clipboard = "unnamedplus"` 설정이 동작하려면 win32yank가 필요합니다.

```bash
# winget으로 설치 (PowerShell)
winget install --id=wez.wezterm  # 또는 직접 다운로드

# 또는 apt
sudo apt install xclip
```

PowerShell에서 win32yank를 PATH에 등록하거나, WSL에서 아래 방법 사용:
```bash
curl -sLo /tmp/win32yank.zip https://github.com/equalsraf/win32yank/releases/latest/download/win32yank-x64.zip
unzip /tmp/win32yank.zip -d /tmp/win32yank
sudo mv /tmp/win32yank/win32yank.exe /usr/local/bin/
```
