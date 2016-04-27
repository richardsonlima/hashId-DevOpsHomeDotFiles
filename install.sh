#!/bin/bash

# Program information
name="hashId-DevOpsHomeDotFile"
version="1.0.1"
releasedate="27 Abr 2016"
author="by Richardson Lima"
author_contact="contato@richardsonlima.com.br"
website="http://www.richardsonlima.com.br"
copyright="Copyright 2016 - ${author}, ${website}"

# set -x

# Initialize defaults
# Variable initializing
    PROGRAM_name=" hashId-DevOpsHomeDotFile"
    PROGRAM_CV="v1.0.0"
    PROGRAM_LV="v1.0.1"
    PROFILE=""
##
# Colors

    NORMAL="\033[1;39m"
    WARNING="\033[1;31m"          # Bad (red)
    TITLE="\033[0;34m"            # Information (blue)
    NOTICE="\033[1;33m"           # Notice (yellow)
    OK="\033[1;32m"               # Ok (green)
    BAD="\033[1;31m"              # Bad (red)

    # Normal color names
    YELLOW="\033[1;33m"
    WHITE="\033[1;37m"
    GREEN="\033[1;32m"
    RED="\033[1;31m"
    PURPLE="\033[0;35m"
    MAGENTA="\033[1;35m"
    BROWN="\033[0;33m"
    CYAN="\033[0;36m"
    BLUE="\033[0;34m"
#

disclaimer(){
echo -e ""
            echo -e "      ==============================================================================="
            echo -e "        ${NOTICE} ${PROGRAM_name} ${NORMAL}"
            echo -e "      ==============================================================================="
            echo -e ""
            echo -e "        Current version : ${YELLOW}${PROGRAM_CV}${NORMAL}   Latest version : ${GREEN}${PROGRAM_LV}${NORMAL}"
            echo -e ""
            echo -e "        ${WHITE}Please update to the latest version for new features, bug fixes, tests"
            echo -e "        and baselines.${NORMAL}"
            echo -e ""
            echo -e "        Git Official Repo: https://www.hashidsecscan.com.br/downloads/"
            echo -e "        *** ATTENTION: This program was tested on Ubuntu 16.04 desktop "
            echo -e "        $copyright "
            echo -e "      ==============================================================================="
            echo -e ""
            sleep 5
##
    echo
    echo -e "\033[0;36m [*] System Information \033[m";
    echo -e "\033[0;36m [+] Operation System: \033[m" $(python -c 'import platform; print platform.system()' )
    echo -e "\033[0;36m [+] Hostname: \033[m" $(python -c 'import socket; print socket.gethostname()' )
    echo -e "\033[0;36m [+] Distro: \033[m" $(python -c 'import platform; print platform.dist()' )
    echo -e "\033[0;36m [+] Version/Kernel: \033[m" $(python -c 'import platform; print platform.release()' )
    echo -e "\033[0;36m [+] Arch: \033[m" $(python -c 'import platform; print platform.machine()' )
    #echo -e "\033[1;32m [+] Server ID: \033[m"; sudo dmidecode -s system-uuid
    echo -e "\033[0;36m [+] UUID: \033[m" $(python -c 'import os; os.system("sudo dmidecode -s system-uuid")')
    echo
##
}

CURRENT=`pwd`
INSTALL_COMPOSER=true
INSTALL_POWERLINE=true
INSTALL_TERM=true
#INSTALL_ANSIBLE=true
INSTALL_ANSIBLE=false

# Parsing options
if [ $# -gt 0 ] ; then
    for arg in $@ ; do
        if [ $arg = '--no-powerline' ] ; then
            INSTALL_POWERLINE=false
        elif [ $arg = '--no-composer' ] ; then
            INSTALL_COMPOSER=false
        elif [ $arg = '--no-term' ] ; then
            INSTALL_TERM=false
        elif [ $arg = '--ansible' ] ; then
            INSTALL_ANSIBLE=true
        elif [ $arg = '--help' ] ; then
            printf "\033[0;32m [*] hashIdOpsPerfectDesktop -  DevOps and SysOps Ubuntu perfect desktop tools \033[0m\n\n"
            printf "\033[0;32m [+] Author: Richardson Lima - contato at richardsonlima dot com dot br \033[0m\n\n"
            printf "\033[0;33mUsage:\033[0m\n"
            printf "  ./install.sh [options]\n\n"
            printf "\033[0;33mOptions:\033[0m\n"
            printf "  \033[0;32m--no-powerline\033[0m\t\tDon't install powerline\n"
            printf "  \033[0;32m--no-composer\033[0m\t\tDon't install composer\n"
            printf "  \033[0;32m--no-term\033[0m\t\tDon't install term terminator\n"
            printf "  \033[0;32m--ansible\033[0m\t\tInstall ansible and a configuration\n"
            printf "  \033[0;32m--help\033[0m\t\tDisplay this help message\n"
            exit 0;
        fi
    done
fi

PACKAGE='git jq git-core tig curl php python-pip python-psutil htop glances rdesktop cifs-utils vim tmux gtkterm openssh-server filezilla'

if $INSTALL_TERM ; then
   disclaimer
    if [ -f ~/.config/terminator/config ] ; then
        cat ~/.config/terminator/config > ~/.config/terminator/config.backup
        rm -rf ~/.config/terminator
        printf "\033[0;36m [+] Existing .config terminator > save\033[0m \033[0;32m~/.config/terminator/config.backup\033[0m\n"
    fi

    ln -sf $CURRENT/_config/terminator/ ~/.config/terminator

    PACKAGE="$PACKAGE terminator"
fi

if $INSTALL_ANSIBLE ; then
   disclaimer
    if [ -f ~/.ansible.cfg ] ; then
        cat ~/.ansible.cfg > ~/ansible.cfg.backup
        rm -f ~/.ansible.cfg
        printf "\033[0;36m [+] Existing .ansible.cfg > save\033[0m \033[0;32m~/ansible.cfg.backup\033[0m\n"
    fi

    #sudo add-apt-repository ppa:rquillo/ansible

    ln -sf $CURRENT/ansible.cfg ~/.ansible.cfg

    PACKAGE="$PACKAGE ansible"
fi

printf "\033[0;32m [+] Install packages $PACKAGE\033[0m\n"
sudo apt-get update
sudo apt-get install $PACKAGE -y
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

if $INSTALL_POWERLINE ; then
    echo -e '\033[0;36m [+] Powerline Installation \033[0m'
    echo ""
    function add_line() {
    LINE="$1"
    FILE=$2
    grep -F -q "${LINE}" ${FILE} || (echo -e '\n# Powerline shell changes' >> ${FILE} && echo ${LINE} >> ${FILE})
}
pip install setuptools
pip install --user git+git://github.com/powerline/powerline

LINE='if [ -d "$HOME/.local/bin" ] ; then PATH="$HOME/.local/bin:$PATH"; fi'
add_line "${LINE}" ~/.profile

wget https://github.com/Lokaltog/powerline/raw/develop/font/PowerlineSymbols.otf https://github.com/Lokaltog/powerline/raw/develop/font/10-powerline-symbols.conf
mkdir -p ~/.fonts/ && mv PowerlineSymbols.otf ~/.fonts/
fc-cache -vf ~/.fonts
mkdir -p ~/.config/fontconfig/conf.d/ && mv 10-powerline-symbols.conf ~/.config/fontconfig/conf.d/

LINE='if [ -f ~/.local/lib/python2.7/site-packages/powerline/bindings/bash/powerline.sh ]; then source ~/.local/lib/python2.7/site-packages/powerline/bindings/bash/powerline.sh; fi'
add_line "${LINE}" ~/.bashrc

# Use the "default_leftonly" theme
CFG_FILE=~/.local/lib/python2.7/site-packages/powerline/config_files/config.json
jq '(.ext.shell.theme = "default_leftonly")' "${CFG_FILE}" > tmp.$$.json && mv tmp.$$.json ${CFG_FILE}

fi

echo -e '\033[0;36m [+] End [!!!] \033[0m'
