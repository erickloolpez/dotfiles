set fish_greeting ""

set -gx TERM xterm-256color

# theme
set -g theme_color_scheme terminal-dark
set -g fish_prompt_pwd_dir_length 1
set -g theme_display_user yes
set -g theme_hide_hostname no
set -g theme_hostname always

# aliases
alias ls "ls -p -G"
alias la "ls -A"
alias ll "ls -l"
alias lla "ll -A"
alias g git
alias c claude
alias claude-yolo "claude --dangerously-skip-permissions"
command -qv nvim && alias vim nvim

set -gx EDITOR nvim

set -gx PATH bin $PATH
set -gx PATH ~/bin $PATH
set -gx PATH ~/.local/bin $PATH

function ide
    # Primero verifica si tmux está corriendo
    if not tmux list-sessions >/dev/null 2>&1
        echo "Iniciando nueva sesión de tmux..."
        tmux new-session -d
    end

    # Ejecuta el script de configuración
    ~/.config/scripts/ide # Cambia esta ruta si moviste el archivo
end

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
set -gx PATH $PATH /opt/nvim-linux-x86_64/bin
