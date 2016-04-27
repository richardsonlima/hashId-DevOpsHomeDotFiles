#!/usr/bin/env bash
# set -x

CURRENT=`pwd`
INSTALL_COMPOSER=true
INSTALL_ZSH=true
INSTALL_TERM=true
#INSTALL_ANSIBLE=true
INSTALL_ANSIBLE=false

# Parsing options
if [ $# -gt 0 ] ; then
    for arg in $@ ; do
        if [ $arg = '--no-zsh' ] ; then
            INSTALL_ZSH=false
        elif [ $arg = '--no-composer' ] ; then
            INSTALL_COMPOSER=false
        elif [ $arg = '--no-term' ] ; then
            INSTALL_TERM=false
        elif [ $arg = '--ansible' ] ; then
            INSTALL_ANSIBLE=true
        elif [ $arg = '--help' ] ; then
            printf "\033[0;32m [+] hashId DevOps/SysAdmin/SysOps Home DotFiles and tools: \033[0m\n\n"
            printf "\033[0;32m [+] Author: Richardson Lima - contato at richardsonlima dot com dot br \033[0m\n\n"
            printf "\033[0;33mUsage:\033[0m\n"
            printf "  ./install.h [options]\n\n"
            printf "\033[0;33mOptions:\033[0m\n"
            printf "  \033[0;32m--no-zsh\033[0m\t\tDon't install zsh\n"
            printf "  \033[0;32m--no-composer\033[0m\t\tDon't install composer\n"
            printf "  \033[0;32m--no-term\033[0m\t\tDon't install term terminator\n"
            printf "  \033[0;32m--ansible\033[0m\t\tInstall ansible and a configuration\n"
            printf "  \033[0;32m--help\033[0m\t\tDisplay this help message\n"
            exit 0;
        fi
    done
fi

PACKAGE=' git-core tig curl php python-pip python-psutil htop glances rdesktop cifs-utils vim tmux gtkterm openssh-server filezilla virtualbox-5.0'

if $INSTALL_TERM ; then
    if [ -f ~/.config/terminator/config ] ; then
        cat ~/.config/terminator/config > ~/.config/terminator/config.backup
        rm -rf ~/.config/terminator
        printf "\033[0;36m [+] Existing .config terminator > save\033[0m \033[0;32m~/.config/terminator/config.backup\033[0m\n"
    fi

    ln -sf $CURRENT/_config/terminator/ ~/.config/terminator

    PACKAGE="$PACKAGE terminator"
fi

if $INSTALL_ANSIBLE ; then
    if [ -f ~/.ansible.cfg ] ; then
        cat ~/.ansible.cfg > ~/ansible.cfg.backup
        rm -f ~/.ansible.cfg
        printf "\033[0;36m [+] Existing .ansible.cfg > save\033[0m \033[0;32m~/ansible.cfg.backup\033[0m\n"
    fi

    #sudo add-apt-repository ppa:rquillo/ansible

    ln -sf $CURRENT/ansible.cfg ~/.ansible.cfg

    PACKAGE="$PACKAGE ansible"
fi

if $INSTALL_ZSH ; then
    PACKAGE="$PACKAGE zsh"
    echo -e '\033[0;36m [+] zsh Installation \033[0m'
    sh $CURRENT/zsh-config/zsh-install.sh
    echo ""
    printf "   \033[0;36m [+] Create symlinks: \033[0m\n"
    printf "   \033[0;36m [+] .zshr\033[0m\n"
    ln -sf $CURRENT/zsh-config/.zshr ~/.zshr
    chsh -s /bin/zsh || chsh -s `which zsh`

fi
printf "\033[0;32m [+] Install package$PACKAGE\033[0m\n"
sudo apt-get update
sudo apt-get install $PACKAGE
echo ""
printf "\033[0;32mTest files exist ~/.gitconfig ~/.gitignore_global ~/.config/fontconfig\033[0m\n"
if [ -f ~/.gitconfig ] ; then
    cat ~/.gitconfig > ~/gitconfig.backup
    rm -f ~/.gitconfig
    printf "\033[0;36m [+] Existing .gitconfig\t\t> save\033[0m \033[0;32mgitconfig.backup\033[0m\n"
fi

if [ -f ~/.gitignore_global ] ; then
    cat ~/.gitignore_global > ~/gitignore_global.backup
    rm -f ~/.gitignore_global
    printf "   \033[0;36m [+] Existing .gitignore_global\t> save\033[0m \033[0;32mgitignore_global.backup\033[0m\n"
fi

if [ -f ~/.config/fontconfig ] ; then
    rm -rf ~/.config/fontconfig
    printf "   \033[0;36m [+] Existing .config/fontconfig\033[0m \033[0;33m=> remove\033[0m\n"
fi

echo ""
printf "   \033[0;36m [+] Create symlinks: \033[0m\n"
printf "   \033[0;36m [+] .gitconfig\033[0m\n"
ln -sf $CURRENT/gitconfig ~/.gitconfig
printf "   \033[0;36m [+] .gitignore_global\033[0m\n"
ln -sf $CURRENT/gitignore_global ~/.gitignore_global
printf "   \033[0;36m [+] .config/fontconfig\033[0m\n"
ln -sf $CURRENT/_config/fontconfig/ ~/.config/fontconfig
printf "   \033[0;36m [+] .fonts\033[0m\n"
ln -sf $CURRENT/_fonts/ ~/.fonts

echo ""
printf "\033[0;36m [+] Load fonts: \033[0m\n"
fc-cache -vf ~/.fonts
echo ""

if $INSTALL_COMPOSER ; then
    echo -e '\033[0;36m [+] Installation de composer  \033[0m'
    chmod +x $CURRENT/lib/composer.sh && sudo $CURRENT/lib/composer.sh
fi
echo -e '\033[0;36m End [!!!] \033[0m'
