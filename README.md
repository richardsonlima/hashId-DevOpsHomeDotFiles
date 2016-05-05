# DevOps and SysOps Ubuntu perfect desktop tools

Easy way to auto install vagrant build-essential libssl-dev powerline git jq git-core tig curl php php-cli python-pip python-psutil htop glances rdesktop cifs-utils vim tmux gtkterm openssh-server filezilla vim-nox-py2 mysql-utilities python-chef fabric capistrano python-winrm vim-syntax-docker python-docker docker.io ctop cadvisor docker-compose . 

## TODO
-----------
- [x] Create a Terminator isntall;
- [x] Create a Zsh install;
- [x] Create a Atom install;
- [ ] Create a Vagrant install;

## Intallation
-----------
Just run :
* `sudo apt-get install git`
* `git clone https://github.com/richardsonlima/hashId-DevOpsHomeDotFiles.git `
* `cd hashId-DevOpsHomeDotFiles/ && chmod +x *.sh`
* `sudo ./install.sh --help`

3# Options
-------

Possibility not to install some component of the script thanks to options follows:

* `--no-zsh`: not install zsh.
* `--no-term`: not install term terminator.
* `--no-atom`: not install atom - The hackable text editor
* `--help`: Display this help message.
