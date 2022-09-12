### EXPORT ###
export EDITOR='nano'
export VISUAL='nano'
export HISTCONTROL=ignoreboth:erasedups
export PAGER='most'

#Ibus settings if you need them
#type ibus-setup in terminal to change settings and start the daemon
#delete the hashtags of the next lines and restart
#export GTK_IM_MODULE=ibus
#export XMODIFIERS=@im=dbus
#export QT_IM_MODULE=ibus

PS1='[\u@\h \W]\$ '

# If not running interactively, don't do anything
[[ $- != *i* ]] && return


if [ -d "$HOME/.bin" ] ;
  then PATH="$HOME/.bin:$PATH"
fi

if [ -d "$HOME/.local/bin" ] ;
  then PATH="$HOME/.local/bin:$PATH"
fi

### ALIASES ###

alias ls='ls --color=auto'
alias ls='ls --color=auto'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'

#adk-linux news and info
alias News="nano /etc/ase/adk-news.txt"

#pacman unlock
alias unlock="sudo rm /var/lib/pacman/db.lck"
alias rmpacmanlock="sudo rm /var/lib/pacman/db.lck"

#refesh bash
alias refresh="source ~/.bashrc"

alias egrep='egrep --color=auto'

#update all of the packages
alias update='yay -Syyuu'

#clean pacman cache
alias clean='sudo pacman -Qtdq | sudo pacman -Rns - && sudo pacman -Scc'

#generate a password
alias password='openssl rand -base64 14'

#systemd 
alias syse='systemctl list-unit-files --state=enabled'
alias sysd='systemctl list-unit-files --state=disabled'

alias ls='ls --color=auto'

#grub update
alias clean-grub-efi='sudo umount /boot/efi && sudo rm -r /boot/efi && sudo rm -r /boot/grub && sudo mkdir /boot/efi' 
## You will need to mount your boot drive Example "sudo mount /dev/sda1 /boot/efi" ##
alias update-grub='sudo grub-mkconfig -o /boot/grub/grub.cfg'
alias install-grub-efi='sudo grub-install --target=x86_64-efi --efi-directory=/boot/efi --recheck'

#copy/paste all content of /etc/skel over to home folder - backup of config created - beware
alias skel='[ -d ~/.config ] || mkdir ~/.config && cp -Rf ~/.config ~/.config-backup-$(date +%Y.%m.%d-%H.%M.%S) && cp -RTrf /etc/skel/ ~'
#backup contents of /etc/skel to hidden backup folder in home/user
alias bupskel='cp -Rf /etc/skel ~/.skel-backup-$(date +%Y.%m.%d-%H.%M.%S)'

#copy shell configs
alias cb='cp /etc/skel/.bashrc ~/.bashrc && exec bash'
alias cz='cp /etc/skel/.zshrc ~/.zshrc && echo "Copied."'

#hardware info --short
alias hw="hwinfo --short"

#check vulnerabilities microcode
alias microcode='grep . /sys/devices/system/cpu/vulnerabilities/*'

#get fastest mirrors in your neighborhood
alias mirror="sudo reflector -f 30 -l 30 --number 10 --verbose --save /etc/pacman.d/mirrorlist"
alias mirrord="sudo reflector --latest 30 --number 10 --sort delay --save /etc/pacman.d/mirrorlist"
alias mirrors="sudo reflector --latest 30 --number 10 --sort score --save /etc/pacman.d/mirrorlist"
alias mirrora="sudo reflector --latest 30 --number 10 --sort age --save /etc/pacman.d/mirrorlist"
#our experimental - best option for the moment
alias mirrorx="sudo reflector --age 6 --latest 20  --fastest 20 --threads 5 --sort rate --protocol https --save /etc/pacman.d/mirrorlist"
alias mirrorxx="sudo reflector --age 6 --latest 20  --fastest 20 --threads 20 --sort rate --protocol https --save /etc/pacman.d/mirrorlist"
alias ram='rate-mirrors --allow-root arch | sudo tee /etc/pacman.d/mirrorlist'

#buid custom kernel
alias build='cd ~/.build/linux/ && updpkgsums && makepkg -s'
alias git-build="sudo rm -r ~/.build/ && mkdir ~/.build/ && cd ~/.build/ && sudo pacman -Sy asp pacman-contrib --noconfirm --needed && asp update linux && asp export linux && cd ~/.build/linux/ && sed -i 's/^pkgbase=linux.*/pkgbase=linux-adk/' PKGBUILD"

#mount Public for virtualbox
alias mvb='sudo mount -t vboxsf -o rw,uid=1000,gid=1000 Public /home/$USER/Public'

#Recent Installed Packages
alias rip="expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -200 | nl"
alias riplong="expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -3000 | nl"

#iso and version used to install ADK-Linux
alias iso="cat /etc/dev-rel | awk -F '=' '/ISO/ {print $2}'"

#fixes
alias fix-permissions="sudo chown -R $USER:$USER ~/.config ~/.local"
alias keyfix="/usr/local/bin/fix-pacman-databases-and-keys.sh"

#systeminfo
alias probe="sudo -E hw-probe -all -upload"
alias sysfailed="systemctl list-units --failed"

# # ex = EXtractor for all kinds of archives
# # usage: ex <file>
ex ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1   ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *.deb)       ar x $1      ;;
      *.tar.xz)    tar xf $1    ;;
      *.tar.zst)   tar xf $1    ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

#btrfs aliases
alias btrfsfs="sudo btrfs filesystem df /"
alias btrfsli="sudo btrfs su li / -t"

#search with grep
alias pt='grep -Ril'

#make ls look good
alias xls="exa -a --icons --color=always --group-directories-first"
alias xll="exa -lag --icons --color=always --group-directories-first --octal-permissions"

#open in ranger
alias rg='ranger'

##this alias is only to be used in a live enviroment ##
alias rescue='/usr/local/bin/adk-linux_rescue'

PS1='[\u@\h \W]\$ '

#if you would like to have your own aliases then add them to .bashrc-personal file
[[ -f ~/.bashrc-personal ]] && . ~/.bashrc-personal

neofetch
