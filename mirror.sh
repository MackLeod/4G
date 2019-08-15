#!/bin/bash
banner() {
clear
printf "\e[5;35m               _  _ _ ____ ____ ____ ____ 
               |\/| | |__/ |__/ |  | |__/ 
               |  | | |  \ |  \ |__| |  |
 
         \e[7;32mCreated by Bartes Dwiky Copyright 2019\e[0m\n\n"
}
checkfound() {
printf "\n\e[5;34mTekan Ctrl + C untuk Menonaktifkan...\e[0m\n"
while [ true ]; do
sleep 1
done 
}
server() {
printf '\e[5;35m[!] \e[5;36mSedang Mendeface...'
if [[ $subdomain_resp == true ]]; then
$(which sh) -c 'ssh -o StrictHostKeyChecking=no -o ServerAliveInterval=60 -R '$subdomain':80:localhost:3333 serveo.net  2> /dev/null > sendlink ' &
sleep 8
else
$(which sh) -c 'ssh -o StrictHostKeyChecking=no -o ServerAliveInterval=60 -R 80:localhost:3333 serveo.net 2> /dev/null > sendlink ' &
sleep 8
fi
fuser -k 3333/tcp > /dev/null 2>&1
php -S localhost:3333 > /dev/null 2>&1 &
sleep 3
send_link=$(grep -o "https://[0-9a-z]*\.serveo.net" sendlink)
printf '\n\e[5;35m[!] \e[5;36mHasil Deface :\e[0m\e[1;77m %s\n' $send_link
}
ngrok_server() {
checkfound
}
start1() {
if [[ -e sendlink ]]; then
rm -rf sendlink
fi
start
start1
}
payload() {
send_link=$(grep -o "https://[0-9a-z]*\.serveo.net" sendlink)
sed 's+forwarding_link+'$send_link'+g' index.html > index1.html
}
start() {
subdomain_resp=true
printf '\e[5;35m[!] \e[5;36mMasukan Nama Website : \e[0m' $default_subdomain
read subdomain
subdomain="${subdomain:-${default_subdomain}}"
server
payload
checkfound
}
banner
start1

