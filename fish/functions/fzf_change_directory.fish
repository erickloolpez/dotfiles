# fzf_change_directory.fish
function fzf_change_directory_internal
    fzf | perl -pe 's/([ ()])/\\\\$1/g' | read foo
    if test -n "$foo"
        builtin cd $foo
        commandline -r ''
        commandline -f repaint
    else
        commandline ''
    end
end

function fzf_change_directory
    begin
        echo $HOME/.config
        # Si tienes ghq instalado, descomenta la siguiente línea:
        # find $(ghq root) -maxdepth 4 -type d -name .git 2>/dev/null | sed 's/\/\.git//'

        # Directorios locales
        if test (count */) -gt 0
            ls -ad */ | perl -pe "s#^#$PWD/#" | grep -v \.git
        end

        # Directorios en Developments (ajustado para ser más seguro)
        if test -d $HOME/Developments
            find $HOME/Developments -maxdepth 2 -type d 2>/dev/null | grep -v \.git
        end
    end | sed -e 's/\/$//' | awk '!a[$0]++' | fzf_change_directory_internal $argv
end
