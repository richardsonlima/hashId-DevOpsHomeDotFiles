# DevOps and SysOps Ubuntu perfect desktop tools

Easy way to auto install vagrant build-essential libssl-dev powerline git jq git-core tig curl php php-cli python-pip python-psutil htop glances rdesktop cifs-utils vim tmux gtkterm openssh-server filezilla vim-nox-py2 mysql-utilities python-chef fabric capistrano python-winrm vim-syntax-docker python-docker docker.io ctop cadvisor docker-compose . 

Intallation
-----------
Just run :
* `sudo apt-get install git`
* `git clone https://github.com/richardsonlima/hashId-DevOpsHomeDotFiles.git `
* `cd hashId-DevOpsHomeDotFiles/ && chmod +x *.sh`
* `sudo ./install.sh --help`

Options
-------

Possibility not to install some component of the script thanks to options follows:

* `--no-zsh`: not install zsh.
* `--no-term`: not install term terminator.
* `--no-atom`: not install atom - The hackable text editor
* `--help`: Display this help message.
