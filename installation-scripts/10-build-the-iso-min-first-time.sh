#!/bin/bash
#set -e
##################################################################################################################
#
#   DO NOT JUST RUN THIS. EXAMINE AND JUDGE. RUN AT YOUR OWN RISK.
#
##################################################################################################################
echo
echo "################################################################## "
tput setaf 2
echo "Phase 1 : "
echo "- Setting General parameters"
tput sgr0
echo "################################################################## "
echo

	#Only mode this section
	#First letter of desktop is small letter

	desktop="Plasma"
	dmDesktop="plasma"
    codeName="Gothics"
	adkVersion="2022.12.01"
	IsoLabel="adk-min"
	hostName="ADK-Linux"
	arch="x86_64"

    isoLabel="$IsoLabel-$adkVersion-$arch.iso"

	# setting of the general parameters
	archisoRequiredVersion="archiso 68-1"
	buildFolder=$HOME"/adk-build"
	outFolder=$HOME"/ADK-Out"
	archisoVersion=$(sudo pacman -Q archiso)

	echo "################################################################## "
	echo "Building the desktop                   : "$desktop
	echo "Building version                       : "$adkVersion
	echo "Iso label                              : "$isoLabel
	echo "Do you have the right archiso version? : "$archisoVersion
	echo "What is the required archiso version?  : "$archisoRequiredVersion
	echo "Build folder                           : "$buildFolder
	echo "Out folder                             : "$outFolder
	echo "################################################################## "

	if [ "$archisoVersion" == "$archisoRequiredVersion" ]; then
		tput setaf 2
		echo "##################################################################"
		echo "Archiso has the correct version. Continuing ..."
		echo "##################################################################"
		tput sgr0
	else
	tput setaf 1
	echo "###################################################################################################"
	echo "You need to install the correct version of Archiso"
	echo "Use 'sudo downgrade archiso' to do that"
	echo "or update your system"
	echo "###################################################################################################"
	tput sgr0
	fi

echo
echo "################################################################## "
tput setaf 2
echo "Phase 2 :"
echo "- Checking if archiso is installed"
echo "- Saving current archiso version to readme"
echo "- Making mkarchiso verbose"
tput sgr0
echo "################################################################## "
echo

	package="archiso"

	#----------------------------------------------------------------------------------

	#checking if application is already installed or else install with aur helpers
	if pacman -Qi $package &> /dev/null; then

			echo "Archiso is already installed"

	else

		#checking which helper is installed
		if pacman -Qi yay &> /dev/null; then

			echo "################################################################"
			echo "######### Installing with yay"
			echo "################################################################"
			yay -S --noconfirm $package

		elif pacman -Qi trizen &> /dev/null; then

			echo "################################################################"
			echo "######### Installing with trizen"
			echo "################################################################"
			trizen -S --noconfirm --needed --noedit $package

		fi

		# Just checking if installation was successful
		if pacman -Qi $package &> /dev/null; then

			echo "################################################################"
			echo "#########  "$package" has been installed"
			echo "################################################################"

		else

			echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
			echo "!!!!!!!!!  "$package" has NOT been installed"
			echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
			exit 1
		fi

	fi

	echo
	echo "Saving current archiso version to readme"
	sudo sed -i "s/\(^archiso-version=\).*/\1$archisoVersion/" ../adkiso.readme
	echo
	echo "Making mkarchiso verbose"
	sudo sed -i 's/quiet="y"/quiet="n"/g' /usr/bin/mkarchiso

echo
echo "################################################################## "
tput setaf 2
echo "Phase 3 :"
echo "- Deleting the build folder if one exists"
echo "- Copying the Archiso folder to build folder"
tput sgr0
echo "################################################################## "
echo

	echo "Deleting the build folder if one exists - takes some time"
	[ -d $buildFolder ] && sudo rm -rf $buildFolder
	echo
	echo "Copying the Archiso folder to build work"
	echo
	mkdir $buildFolder
	cp -r ../adkiso $buildFolder/adkiso

echo
echo "################################################################## "
tput setaf 2
echo "Phase 4 :"
echo "- Removing the old packages.x86_64 file from build folder"
echo "- Copying the new packages.x86_64 file to the build folder"
echo "- Changing group for polkit folder"
tput sgr0
echo "################################################################## "
echo

	echo "Removing the old packages.x86_64 file from build folder"
	rm $buildFolder/adkiso/packages.x86_64
	echo
	echo "Copying the new packages.x86_64 file to the build folder"
	cp -f ../adkiso/$codeName-packages.x86_64 $buildFolder/adkiso/packages.x86_64
	echo

echo
echo "################################################################## "
tput setaf 2
echo "Phase 5 : "
echo "- Changing all references"
echo "- Adding time to /etc/dev-rel"
tput sgr0
echo "################################################################## "
echo

	#Setting variables

	#profiledef.sh
	oldname1='iso_name='
	newname1='iso_name='$IsoLabel

	oldname2='iso_label='
	newname2='iso_label='$IsoLabel

	oldname7='iso_version='
	newname7='iso_version='$adkVersion

	oldname3='ISO_CODENAME='
	newname3='ISO_CODENAME='$codeName

	#hostname
	oldname4='hostname'
	newname4=$hostName

	#sddm.conf user-session
	oldname5='Session=plasma'
	newname5='Session='$dmDesktop

	#version
	oldname6='ISO_RELEASE='
	newname6='ISO_RELEASE='$adkVersion

	echo "Changing all references"
	echo
	sed -i 's/'$oldname1'/'$newname1'/g' $buildFolder/adkiso/profiledef.sh
	sed -i 's/'$oldname2'/'$newname2'/g' $buildFolder/adkiso/profiledef.sh
	sed -i 's/'$oldname7'/'$newname7'/g' $buildFolder/adkiso/profiledef.sh
	sed -i 's/'$oldname3'/'$newname3'/g' $buildFolder/adkiso/airootfs/etc/dev-rel
	sed -i 's/'$oldname4'/'$newname4'/g' $buildFolder/adkiso/airootfs/etc/hostname
	sed -i 's/'$oldname5'/'$newname5'/g' $buildFolder/adkiso/airootfs/etc/sddm.conf.d/adk_settings
	sed -i 's/'$oldname6'/'$newname6'/g' $buildFolder/adkiso/airootfs/etc/dev-rel

	echo "Adding time to /etc/dev-rel"
	date_build=$(date -d now)
	echo "Iso build on : "$date_build
	sudo sed -i "s/\(^ISO_BUILD=\).*/\1$date_build/g" $buildFolder/adkiso/airootfs/etc/dev-rel

echo
echo "################################################################## "
tput setaf 2
echo "Phase 6 :"
echo "- Cleaning the cache from /var/cache/pacman/pkg/"
tput sgr0
echo "###########################################################"
echo

	echo "Cleaning the cache from /var/cache/pacman/pkg/"
	yes | sudo pacman -Scc

echo
echo "################################################################## "
tput setaf 2
echo "Phase 7 :"
echo "- Building the iso - this can take a while - be patient"
tput sgr0
echo "################################################################## "
echo

	[ -d $outFolder ] || mkdir $outFolder
	cd $buildFolder/adkiso/
	sudo mkarchiso -G -v -w $buildFolder -o $outFolder $buildFolder/adkiso/



echo
echo "###################################################################"
tput setaf 2
echo "Phase 7 :"
echo "- Creating checksums"
echo "- Copying pgklist"
tput sgr0
echo "###################################################################"
echo

	cd $outFolder

	echo "Creating checksums for : "$isoLabel
	echo "##################################################################"
	echo
	echo "Building sha256sum"
	echo "########################"
	sha256sum $isoLabel | tee $isoLabel.sha256
	echo
	echo "Moving pkglist.x86_64.txt"
	echo "########################"
	cp $buildFolder/iso/arch/pkglist.x86_64.txt  $outFolder/$isoLabel".pkglist.txt"

echo
echo "##################################################################"
tput setaf 2
echo "Phase 8 :"
echo "- Making sure we start with a clean slate next time"
tput sgr0
echo "################################################################## "
echo

	echo "Deleting the build folder if one exists - takes some time"
	[ -d $buildFolder ] && sudo rm -rf $buildFolder

echo
echo "##################################################################"
tput setaf 2
echo "DONE"
echo "- Check your out folder :"$outFolder
tput sgr0
echo "################################################################## "
echo
