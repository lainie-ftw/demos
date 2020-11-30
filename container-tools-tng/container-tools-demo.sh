#!/usr/bin/env bash 

# author: Laine Minor @lainie-ftw lainelminor@gmail.com
# author: Joshua Smith @joshmsmith joshmsmith@gmail.com

#Setting up some colors for helping read the demo output
#Using ${green}GREEN${reset} for UI pauses
#Using ${blue}BLUE${reset} for script steps
#Using ${purple}PURPLE${reset} for calling out specific container tools

green=$(tput setaf 2)
blue=$(tput setaf 4)
purple=$(tput setaf 125)
reset=$(tput sgr0)

#Let's do this thing...
read -p "${green}Let's see some cool container stuff! What's your Quay.io user ID? You'll need to be logged in to Quay.io for this to work. ${reset}" quayID

read -p "${blue}1. Git clone the demo repo.${reset}"
cd Workspaces
git clone https://github.com/containers/Demos.git
cd Demos/building/myweather

read -p "${blue}2. Show off the Dockerfile that builds the container.${reset}"
cat Dockerfile.weather

read -p "${blue}3. Build the container locally via ${purple}podman${blue}. ${reset}"
echo -e "${purple}podman build -t weather -f Dockerfile.weather .\n${reset}"
sudo podman build -t weather -f Dockerfile.weather .

read -p "${blue}4. Run the application locally ${purple}(still podman)${blue}. ${reset}"
echo -e "${purple}podman run --tty=true -a=stdin -a=stdout weather\n${reset}"
sudo podman run --tty=true -a=stdin -a=stdout weather

read -p "${blue}4. Run it one more time! ${reset}"
sudo podman run --tty=true -a=stdin -a=stdout weather

read -p "${blue}5. Push the local image to ${purple}${quayID}'s Quay ${blue}account, using ${purple}podman. ${reset}"
echo -e "${purple}podman push weather quay.io/${quayID}/weather\n${reset}"
sudo podman push weather quay.io/${quayID}/weather

read -p "${blue}6. Copy from one repo to another within ${purple}${quayID}'s Quay ${blue}account, using ${purple}skopeo${blue}. ${reset}"
echo -e "${purple}skopeo copy docker://quay.io/${quayID}/weather docker://quay.io/${quayID}/uberconf2020\n${reset}"
sudo skopeo copy docker://quay.io/${quayID}/weather docker://quay.io/${quayID}/uberconf2020
