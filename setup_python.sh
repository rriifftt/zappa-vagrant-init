### initialze
sudo yum install -y gcc libffi-devel python-devel openssl-devel zlib-devel bzip2 bzip2-devel readline-devel sqlite sqlite-devel openssl-devel git vim

### pip
curl -L https://bootstrap.pypa.io/get-pip.py | sudo python
sudo pip install pip --upgrade

### pyenv + virtualenv
curl -L https://raw.githubusercontent.com/yyuu/pyenv-installer/master/bin/pyenv-installer | bash
cat << 'EOF' >> ~/.bash_profile

### virtualenv
export PATH="/home/vagrant/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
EOF

### virtualenv wrapper
sudo pip install virtualenvwrapper
export WORKON_HOME="~/python-venv"
mkdir -p $WORKON_HOME
virtualenvwrapper_sh=$(whereis virtualenvwrapper.sh | cut -d : -f2)
echo """
if [ -f ${virtualenvwrapper_sh} ]; then
    export WORKON_HOME=$HOME/.virtualenvs
    source ${virtualenvwrapper_sh}
fi
""" >> ~/.bash_profile
source ${virtualenvwrapper_sh}

### prompt
cat << 'EOF' >> ~/.bashrc

# prompt
PS1='\u \[\033[0;33m\]\t\[\033[00m\] \w\$ \[\033[01;35m\]$(if git status &>/dev/null;then echo git[$(git branch | grep "\*" | sed "s/\* //") =\> $(git status -s |wc -l)];fi)\[\033[00m\] '
EOF
. ~/.bashrc

### install python
$(which pyenv) install 2.7.12
$(which pyenv) local 2.7.12
mkvirtualenv zappa_2.7.12
