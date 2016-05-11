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
    PROGRAM_name="hashIdOpsPerfectDesktop -  DevOps and SysOps Ubuntu perfect desktop tools"
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
echo 
            echo -e "      ==============================================================================="
            echo -e "        ${NOTICE} ${PROGRAM_name} ${NORMAL}"
            echo -e "      ==============================================================================="
            echo -e ""
            echo -e "        Current version : ${YELLOW}${PROGRAM_CV}${NORMAL}   Latest version : ${GREEN}${PROGRAM_LV}${NORMAL}"
            echo -e ""
            echo -e "        ${WHITE}Please update to the latest version for new features, bug fixes, tests"
            echo -e "        and baselines.${NORMAL}"
            echo -e ""
            echo -e "        Git Official Repo: https://github.com/richardsonlima/hashId-DevOpsHomeDotFiles.git"
            echo -e "        *** ATTENTION: This program was tested on Ubuntu 16.04 desktop "
            echo -e "        $copyright "
            echo -e "      ==============================================================================="
            echo 
            sleep 5
##
    echo
    echo -e "\033[0;36m [*] System Information \033[m";
    echo -e "\033[0;36m [+] Operation System: \033[m" $(python -c 'import platform; print platform.system()' )
    echo -e "\033[0;36m [+] Hostname: \033[m" $(python -c 'import socket; print socket.gethostname()' )
    echo -e "\033[0;36m [+] Distro: \033[m" $(python -c 'import platform; print platform.dist()' )
    echo -e "\033[0;36m [+] Version/Kernel: \033[m" $(python -c 'import platform; print platform.release()' )
    echo -e "\033[0;36m [+] Arch: \033[m" $(python -c 'import platform; print platform.machine()' )
    echo -e "\033[0;36m [+] UUID: \033[m" $(python -c 'import os; os.system("sudo dmidecode -s system-uuid")')
    echo
    sleep 5
##
}

CURRENT=`pwd`
INSTALL_POWERLINE=true
INSTALL_TERM=true
INSTALL_ATOM=true
INSTALL_ANSIBLE=false

# Parsing options
if [ $# -gt 0 ] ; then
    for arg in $@ ; do
        if [ $arg = '--no-powerline' ] ; then
            INSTALL_POWERLINE=false
        elif [ $arg = '--no-term' ] ; then
            INSTALL_TERM=false
        elif [ $arg = '--no-atom' ] ; then
            INSTALL_ATOM=false
        elif [ $arg = '--ansible' ] ; then
            INSTALL_ANSIBLE=true
        elif [ $arg = '--help' ] ; then
            printf "\033[0;32m [*] hashIdOpsPerfectDesktop -  DevOps and SysOps Ubuntu perfect desktop tools \033[0m\n\n"
            printf "\033[0;32m [+] Author: Richardson Lima - contato at richardsonlima dot com dot br \033[0m\n\n"
            printf "\033[0;33mUsage:\033[0m\n"
            printf "  ./install.sh [options]\n\n"
            printf "\033[0;33mOptions:\033[0m\n"
            printf "  \033[0;32m--no-powerline\033[0m\t\tDon't install powerline\n"
            printf "  \033[0;32m--no-term     \033[0m\t\tDon't install term terminator\n"
            printf "  \033[0;32m--no-atom     \033[0m\t\tDon't install atom - The hackable text editor\n"
            printf "  \033[0;32m--ansible     \033[0m\t\tInstall ansible and a configuration\n"
            printf "  \033[0;32m--help        \033[0m\t\tDisplay this help message\n"
            exit 0;
        fi
    done
fi

PACKAGE='build-essential libssl-dev powerline git jq git-core tig curl php php-cli python-pip python-psutil htop glances rdesktop cifs-utils vim tmux gtkterm openssh-server filezilla vim-nox-py2 mysql-utilities python-chef fabric capistrano python-winrm vim-syntax-docker python-docker docker.io ctop cadvisor docker-compose vagrant'

if $INSTALL_TERM ; then
   disclaimer
    if [ -f ~/.config/terminator/config ] ; then
        cat ~/.config/terminator/config > ~/.config/terminator/config.backup
        rm -rf ~/.config/terminator
        printf "\033[0;36m [+] Existing .config terminator > save\033[0m \033[0;32m~/.config/terminator/config.backup\033[0m\n"
        echo
        sleep 3
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
        echo
        sleep 3
    fi

    #sudo add-apt-repository ppa:rquillo/ansible

    ln -sf $CURRENT/ansible.cfg ~/.ansible.cfg

    PACKAGE="$PACKAGE ansible"
fi

printf "\033[0;32m [+] Installing packages $PACKAGE\033[0m\n"
sudo apt-get update
sudo apt-get install $PACKAGE -y
echo 
sleep 3
echo 
printf "\033[0;32mTest files exist ~/.gitconfig ~/.gitignore_global ~/.config/fontconfig\033[0m\n"
if [ -f ~/.gitconfig ] ; then
    cat ~/.gitconfig > ~/gitconfig.backup
    rm -f ~/.gitconfig
    sleep 3
    echo 
    printf "\033[0;36m [+] Existing .gitconfig\t\t> save\033[0m \033[0;32mgitconfig.backup\033[0m\n"
    sleep 3
fi

if [ -f ~/.gitignore_global ] ; then
    cat ~/.gitignore_global > ~/gitignore_global.backup
    rm -f ~/.gitignore_global
    printf "   \033[0;36m [+] Existing .gitignore_global\t> save\033[0m \033[0;32mgitignore_global.backup\033[0m\n"
    echo 
    sleep 3
fi

if [ -f ~/.config/fontconfig ] ; then
    rm -rf ~/.config/fontconfig
    printf "   \033[0;36m [+] Existing .config/fontconfig\033[0m \033[0;33m=> remove\033[0m\n"
    echo 
    sleep 3
fi

echo
printf "   \033[0;36m [+] Create symlinks: \033[0m\n"
printf "   \033[0;36m [+] .gitconfig\033[0m\n"
ln -sf $CURRENT/gitconfig ~/.gitconfig
echo
sleep 3
printf "   \033[0;36m [+] .gitignore_global\033[0m\n"
ln -sf $CURRENT/gitignore_global ~/.gitignore_global
echo
sleep 3
printf "   \033[0;36m [+] .config/fontconfig\033[0m\n"
ln -sf $CURRENT/_config/fontconfig/ ~/.config/fontconfig
echo
sleep 3
printf "   \033[0;36m [+] .fonts\033[0m\n"
ln -sf $CURRENT/_fonts/ ~/.fonts
echo
sleep 3

printf "   \033[0;36m [+] Loading fonts: \033[0m\n"
fc-cache -vf ~/.fonts
echo 
sleep 3

if $INSTALL_POWERLINE ; then
    echo 
    echo -e '\033[0;36m [+] Setting Powerline for Bash Shell and Vim Statuslines \033[0m'
    echo
    echo -e '\033[0;36m [+] Installing Powerline on Bash Shell \033[0m'
    echo 
    sudo pip install setuptools
    sudo pip install git+git://github.com/Lokaltog/powerline
    
    echo -e '\033[0;36m [+] Installing Powerline Fonts in Linux \033[0m'
    cp $CURRENT/powerline-config/PowerlineSymbols.otf /usr/share/fonts/
    echo
    echo -e '\033[0;36m [+] Updating your system’s font cache \033[0m'
    sudo fc-cache -vf /usr/share/fonts/
    echo -e '\033[0;36m [+] Installing the fontconfig file \033[0m'
    cp $CURRENT/powerline-config/10-powerline-symbols.conf /etc/fonts/conf.d/
    echo
    echo -e '\033[0;36m [+] Making your terminal to support 256color \033[0m' 
    echo "export TERM="screen-256color" " >> ~/.bashrc
    echo -e '\033[0;36m [+] Enable Powerline on Bash Shell \033[0m' 
    echo "powerline-daemon -q" >> ~/.bashrc
    echo "POWERLINE_BASH_CONTINUATION=1" >> ~/.bashrc
    echo "POWERLINE_BASH_SELECT=1" >> ~/.bashrc
    echo ". /usr/local/lib/python2.7/dist-packages/powerline/bindings/bash/powerline.sh" >> ~/.bashrc 
    echo -e '\033[0;36m [+] Getting the location of installed powerline \033[0m'
    sudo pip show powerline-status
    
    powerline-daemon -q
    POWERLINE_BASH_CONTINUATION=1
    POWERLINE_BASH_SELECT=1
    . /usr/local/lib/python2.7/dist-packages/powerline/bindings/bash/powerline.sh 
    .  ~/.bashrc
    echo
    sleep 3
    echo 
    echo -e '\033[0;36m [+] Enabling Powerline for Vim \033[0m'
    echo "set  rtp+=/usr/local/lib/python2.7/dist-packages/powerline/bindings/vim/" >> ~/.vimrc
    echo "set laststatus=2" >> ~/.vimrc
    echo "set t_Co=256" >> ~/.vimrc
    .  ~/.vimrc
    curl http://j.mp/spf13-vim3 -L -o - | sh && reset
    echo
    sleep 3 

fi

if $INSTALL_ATOM ; then
    echo
    echo -e '\033[0;36m [+] Installing Atom - The hackable text editor\033[0m'
    echo 
    sleep 3
    echo -e '\033[0;36m [+] Installing Nodejs \033[0m'
    sudo apt-get install libgnome-keyring-dev fakeroot -y
    curl -sL https://deb.nodesource.com/setup | sudo bash -
    sudo apt-get install -y nodejs nodejs-legacy nodejs-dev
    sudo apt-get install -y npm
    curl https://raw.githubusercontent.com/creationix/nvm/v0.16.1/install.sh | sh
    . ~/.profile
    nvm ls-remote
    nvm install 0.11.13
    nvm use 0.11.13
    node -v
    nvm ls
    nvm alias default 0.11.13
    nvm use default
    echo
    echo -e '\033[0;36m [+] Resetting terminal to load node and nvm ...\033[0m'
    echo 
    sleep 3
    reset
    echo
    sleep 3 

    echo -e '\033[0;36m [+] Cloning the Atom repository \033[0m'
    git clone https://github.com/atom/atom
    cd atom
    echo
    sleep 3 

    echo -e '\033[0;36m [+] Checkout the latest Atom release \033[0m'
    git fetch
    git checkout $(git describe --tags `git rev-list --tags --max-count=1`)
    echo
    sleep 3 

    echo -e '\033[0;36m [+] Building Atom \033[0m'
    script/build
    echo
    sleep 3 

    echo -e '\033[0;36m [+] Installing the atom and apm commands to /usr/local/bin by executing \033[0m'
    sudo script/grunt install
    echo
    sleep 3 

fi


echo -e '\033[0;36m [+] End [!!!] \033[0m'
