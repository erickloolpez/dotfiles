set fish_greeting ""

set -gx TERM xterm-256color

# theme
set -g theme_color_scheme terminal-dark
set -g fish_prompt_pwd_dir_length 1
set -g theme_display_user yes
set -g theme_hide_hostname no
set -g theme_hostname always

# aliases
alias g git
alias c claude
alias claude-yolo "claude --dangerously-skip-permissions"
# aliases with eza
# Basic replacements for ls commands
alias ls='eza --icons=always --color=always'
alias ll='eza -l --icons=always --color=always --git --header'
alias la='eza -la --icons=always --color=always --git --header'
alias l='eza -1 --icons=always --color=always'

# Tree views
alias tree='eza --tree --icons=always --color=always'
alias treed='eza --tree --only-dirs --icons=always --color=always'

# Special views
alias ld='eza -D --icons=always --color=always' # Only directories
alias lf='eza -f --icons=always --color=always' # Only files

# Navigation helpers (combine with cd)
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

# Funciones súper útiles de fzf para Fish
# Agrega estas a tu ~/.config/fish/config.fish

# Buscar y editar archivos rápidamente
function fe
    set file (fzf --preview 'bat --color=always {}' --preview-window=right:60%)
    if test -n "$file"
        $EDITOR "$file"
    end
end

# Buscar y abrir con VS Code
function fc
    set file (fzf --preview 'bat --color=always {}' --preview-window=right:60%)
    if test -n "$file"
        code "$file"
    end
end

# Buscar y cambiar a directorio
function fd
    set dir (find . -type d 2>/dev/null | fzf --preview 'eza --tree --level=2 --color=always {}')
    if test -n "$dir"
        cd "$dir"
    end
end

# Buscar en historial y ejecutar comando
function fh
    set cmd (history | fzf --tac --no-sort)
    if test -n "$cmd"
        commandline -r "$cmd"
    end
end

# Buscar variables de entorno
function fenv
    env | fzf
end

# Buscar paquetes instalados (brew)
function fbrew
    brew list | fzf --preview 'brew info {}'
end

# Buscar archivos por extensión
function fext
    if test (count $argv) -eq 0
        echo "Usage: fext <extension>"
        return 1
    end
    find . -name "*.$argv[1]" | fzf --preview 'bat --color=always {}'
end

# Buscar archivos grandes
function fbig
    find . -type f -exec du -h {} + | sort -hr | head -50 | fzf | cut -f2 | xargs nvim
end

command -qv nvim && alias vim nvim

set -gx EDITOR nvim

set -gx PATH bin $PATH
set -gx PATH ~/bin $PATH
set -gx PATH ~/.local/bin $PATH

# NodeJS
set -gx PATH node_modules/.bin $PATH

# Go
set -g GOPATH $HOME/go
set -gx PATH $GOPATH/bin $PATH

switch (uname)
    case Darwin
        source (dirname (status --current-filename))/config-osx.fish
    case Linux
        source (dirname (status --current-filename))/config-linux.fish
    case '*'
        source (dirname (status --current-filename))/config-windows.fish
end

set LOCAL_CONFIG (dirname (status --current-filename))/config-local.fish
if test -f $LOCAL_CONFIG
    source $LOCAL_CONFIG
end

mise activate fish | source
