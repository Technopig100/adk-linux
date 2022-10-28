#!/bin/bash
#set -e
##################################################################################################################
# Author 	: Jacob Durant
# Website   : https://www.technopig@hotmail.com.be
# Website   : https://github.com/Technopig100
##################################################################################################################
#
#   DO NOT JUST RUN THIS. EXAMINE AND JUDGE. RUN AT YOUR OWN RISK.
#
##################################################################################################################
#tput setaf 0 = black 
#tput setaf 1 = red 
#tput setaf 2 = green
#tput setaf 3 = yellow 
#tput setaf 4 = dark blue 
#tput setaf 5 = purple
#tput setaf 6 = cyan 
#tput setaf 7 = gray 
#tput setaf 8 = light blue
##################################################################################################################

##################################################################################################################
#
#   DO NOT JUST RUN THIS. EXAMINE AND JUDGE. RUN AT YOUR OWN RISK.
#
##################################################################################################################

# Problem solving commands

# Read before using it.
# https://www.atlassian.com/git/tutorials/undoing-changes/git-reset
# git reset --hard orgin/master
# ONLY if you are very sure and no coworkers are on your github.

# Command that have helped in the past
# Force git to overwrite local files on pull - no merge
# git fetch all
# git push --set-upstream origin master
# git reset --hard orgin/master


project=$(basename `pwd`)
githubdir="Technopig100"
echo "-----------------------------------------------------------------------------"
echo "this is project https://github.com/$githubdir/$project"
echo "-----------------------------------------------------------------------------"

echo
tput setaf 1
echo "################################################################"
echo "#####  Choose wisely - one time setup after clean install   ####"
echo "################################################################"
tput sgr0
echo
echo "Select the correct desktop"
echo
echo "0.  Do nothing"
echo "1.  jacob"
echo "2.  Technopig100"
echo "3.  ADK-Linux"
echo "Type the number..."

read CHOICE

case $CHOICE in

    0 )
      echo
      echo "########################################"
      echo "We did nothing as per your request"
      echo "########################################"
      echo
      ;;

    1 )
			git config --global pull.rebase false
			git config --global push.default simple
			git config --global user.name "Jacob Durant"
			git config --global user.email "technopig@hotmail.com"
			sudo git config --system core.editor nano
      git remote set-url origin git@github.com-arc:$githubdir/$project
      echo
      echo "Everything set"
      ;;
    2 )
			git config --global pull.rebase false
			git config --global push.default simple
			git config --global user.name "Technopig100"
			git config --global user.email "technopig@hotmail.com"
			sudo git config --system core.editor nano
			git config --global credential.helper cache
			git config --global credential.helper 'cache --timeout=32000'
      ;;
    3 )
			git config --global pull.rebase false
			git config --global push.default simple
			git config --global user.name "ADK-Linux"
			git config --global user.email "technopig10@gmail.com"
			sudo git config --system core.editor nano
			git config --global credential.helper cache
			git config --global credential.helper 'cache --timeout=32000'
      ;;
    * )
      echo "#################################"
      echo "Choose the correct number"
      echo "#################################"
      ;;
esac

echo "################################################################"
echo "###################    T H E   E N D      ######################"
echo "################################################################"