#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias ls='ls --color=auto'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias refresh="source ~/.bashrc"
alias egrep='egrep --color=auto'
alias update='yay -Syyuu'
alias clean='sudo pacman -Qtdq | sudo pacman -Rns - && sudo pacman -Scc'
alias password='openssl rand -base64 14'
alias syse='systemctl list-unit-files --state=enabled'
alias sysd='systemctl list-unit-files --state=disabled'
alias ls='ls --color=auto'
alias update-grub='sudo grub-mkconfig -o /boot/grub/grub.cfg'
alias mirror='sudo reflector --latest 5 --sort rate --save /etc/pacman.d/mirrorlist'
alias mirrorx="sudo reflector --age 6 --latest 20  --fastest 20 --threads 5 --sort rate --protocol https --save /etc/pacman.d/mirrorlist"
alias build='cd ~/.build/linux/ && updpkgsums && makepkg -s'
alias git-build="sudo rm -r ~/.build/ && mkdir ~/.build/ && cd ~/.build/ && sudo pacman -Sy asp pacman-contrib --noconfirm --needed && asp update linux && asp export linux && cd ~/.build/linux/ && sed -i 's/^pkgbase=linux.*/pkgbase=linux-adk/' PKGBUILD"
alias mvb='sudo mount -t vboxsf -o rw,uid=1000,gid=1000 Public /home/$USER/Public'
PS1='[\u@\h \W]\$ '

neofetch
