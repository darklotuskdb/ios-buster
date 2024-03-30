#!/bin/bash


Banner(){
echo -e '\e[31m
IIIIIIIIII     OOOOOOOOO        SSSSSSSSSSSSSSS
I::::::::I   OO:::::::::OO    SS:::::::::::::::S
I::::::::I OO:::::::::::::OO S:::::SSSSSS::::::S
II::::::IIO:::::::OOO:::::::OS:::::S     SSSSSSS
  I::::I  O::::::O   O::::::OS:::::S
  I::::I  O:::::O     O:::::OS:::::S
  I::::I  O:::::O     O:::::O S::::SSSS
  I::::I  O:::::O     O:::::O  SS::::::SSSSS
  I::::I  O:::::O     O:::::O    SSS::::::::SS
  I::::I  O:::::O     O:::::O       SSSSSS::::S
  I::::I  O:::::O     O:::::O            S:::::S
  I::::I  O::::::O   O::::::O            S:::::S
II::::::IIO:::::::OOO:::::::OSSSSSSS     S:::::S
I::::::::I OO:::::::::::::OO S::::::SSSSSS:::::S
I::::::::I   OO:::::::::OO   S:::::::::::::::SS
IIIIIIIIII     OOOOOOOOO      SSSSSSSSSSSSSSS

BBBBBBBBBBBBBBBBB                                               tttt
B::::::::::::::::B                                           ttt:::t
B::::::BBBBBB:::::B                                          t:::::t
BB:::::B     B:::::B                                         t:::::t
  B::::B     B:::::Buuuuuu    uuuuuu      ssssssssss   ttttttt:::::ttttttt        eeeeeeeeeeee    rrrrr   rrrrrrrrr
  B::::B     B:::::Bu::::u    u::::u    ss::::::::::s  t:::::::::::::::::t      ee::::::::::::ee  r::::rrr:::::::::r
  B::::BBBBBB:::::B u::::u    u::::u  ss:::::::::::::s t:::::::::::::::::t     e::::::eeeee:::::eer:::::::::::::::::r
  B:::::::::::::BB  u::::u    u::::u  s::::::ssss:::::stttttt:::::::tttttt    e::::::e     e:::::err::::::rrrrr::::::r
  B::::BBBBBB:::::B u::::u    u::::u   s:::::s  ssssss       t:::::t          e:::::::eeeee::::::e r:::::r     r:::::r
  B::::B     B:::::Bu::::u    u::::u     s::::::s            t:::::t          e:::::::::::::::::e  r:::::r     rrrrrrr
  B::::B     B:::::Bu::::u    u::::u        s::::::s         t:::::t          e::::::eeeeeeeeeee   r:::::r
  B::::B     B:::::Bu:::::uuuu:::::u  ssssss   s:::::s       t:::::t    tttttte:::::::e            r:::::r
BB:::::BBBBBB::::::Bu:::::::::::::::uus:::::ssss::::::s      t::::::tttt:::::te::::::::e           r:::::r
B:::::::::::::::::B  u:::::::::::::::us::::::::::::::s       tt::::::::::::::t e::::::::eeeeeeee   r:::::r
B::::::::::::::::B    uu::::::::uu:::u s:::::::::::ss          tt:::::::::::tt  ee:::::::::::::e   r:::::r
BBBBBBBBBBBBBBBBB       uuuuuuuu  uuuu  sssssssssss              ttttttttttt      eeeeeeeeeeeeee   rrrrrrr


\e]0m'														   
echo -e "\e[33m\t\tBy Kamaldeep Bhati (@DarkLotusKDB) <3\n\e[0m"

}

print_usage(){
echo 'Usage: ./ios-buster.sh -a "<app-name>" -d applications/<folder-name>' 
echo 'Usage Ex: ./ios-buster.sh -a "iRecruit" -d applications/recruit'
echo ""
echo -e "\t-a: Just provide the few starting words from the app name. For ex: If app name is 'Resource Centre UAT' then just give 'Resource' as input."
echo -e "\t-d: application folder path (the application folder name should not contain any spaces)."
#echo -e "\t-i: Provide the converted XML readable form Info.plist file path. (preferred 3uTools)"
#echo -e "\t-f: Provide the text file containing sensitive keywords to search such as username, password, agentID, email, etc"
echo ""
echo "Note: 'a-sample-folder' directory is present inside the applications directory for your reference, providing information on the necessary files and folders needed to achieve better results."
}



MainIOS(){
mkdir -p ./"${adn}"/Logs
#sed -i -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//' -e '/^$/d' ./"${adn}"/keywords.txt && truncate -s $(($(stat -c %s ./"${adn}"/keywords.txt) - 1)) ./"${adn}"/keywords.txt
ifile="./"${adn}"/keywords.txt"
#nm=$(find ./input -maxdepth 3 -mindepth 1 -type f -exec file {} \; | grep -i 'executable' | cut -d ":" -f 1 | head -1)

echo -e "\nKamal:~ root#\e[93m ps -A | grep -i "$anm"\e[0m"
ps -A | grep -i "$anm" | grep -iv 'ios-buster\|tee -a\|grep -i'

while true; do
  read -rp "$(echo -e "\e[33m\n[*] Please enter the target app PID from the above output: \e[0m")" -e aid

  if [[ -z $aid ]]; then
    echo "Process ID is required. Please try again."
  elif [[ ! $aid =~ ^[0-9]+$ ]]; then
    echo "Invalid process ID. Please enter a numeric value."
  else
    echo -e "\nProcess ID entered: $aid"
    # Add your desired action here
    break
  fi
done

#sensitive_data
#sd=$(cat "$ifile" | tr -s '\r\n' '\\|')
sd=$(sed 's/^[[:space:]]*//; s/[[:space:]]*$//; /^$/d' "$ifile" | sed 's/$/\\|/g' | sed '$s/\\|//' | tr -d '\n')
echo -e "\e[32m\n[+] Preparing keywords in the grep format (one\|two\|three): \e[0m"
echo "$sd"

if echo "$sd" | grep -E '\\\|$' &> /dev/null 
then echo "[-] Remove empty lines from keywords.txt file" 
fi

if echo "$sd" | grep -E '\\\|\\\|' &> /dev/null 
then echo "[-] Remove empty lines from keywords.txt file" 
fi

sdd=$(sed 's/^[[:space:]]*//; s/[[:space:]]*$//; /^$/d' "$ifile" | sed 's/$/\\|/g' | sed '$s/\\|//' | tr -d '\n' | sed 's/\\|/...\\|../g')
#echo "$sdd"


nm=$( ps -A | grep -i "$anm" | grep $aid | cut -d ":" -f 2 | cut -d " " -f 2,3,4,5,6,7,8,9,10,11)
nf=$( ps -A | grep -i "$anm" | grep $aid | cut -d ":" -f 2 | cut -d " " -f 2,3,4,5 | cut -d "/" -f 1,2,3,4,5,6,7)
nb=$( ps -A | grep -i "$anm" | grep $aid | cut -d ":" -f 2 | cut -d " " -f 2,3,4,5,6,7,8,9,10,11 | cut -d "/" -f 8,9,10,11)


plistutil -f xml -i "$nf/Info.plist" -o "$nf/Info.xml"
iinfo="$nf/Info.xml"
#iinfo="./"${adn}"/input/Info.plist"

pan=$(cat "$iinfo" | grep -i -A1 '<key>CFBundleDisplayName</key>' | tail -1 | sed 's/<string>//' | sed 's/<\/string>//' | sed 's/^[ \t]*//')
echo -e "\n\e[93m[*] Application Name:\e[0m $pan"

echo -e "\n\e[93m[*] Bundle Path:\e[0m $nf"

#Snam="$nf/$pan"
#nf="$Snam"

#GUID
xnm=$(echo "$nm" | cut -d "/" -f 1,2,3,4,5,6,7)

xnma=$(cat "$iinfo" | grep -i -A1 '<key>CFBundleIdentifier</key>' | tail -1 | sed 's/<string>//' | sed 's/<\/string>//' | tr -d "[:blank:]" )
xnmb=$(find /var/mobile/Containers/Data/Application/ \( -type d -name "*$xnma*" -o -type f -name "*$xnma*" \) | cut -d '/' -f 1,2,3,4,5,6,7 | sort -u | head -1)

echo -e "\e[93m[*] Local Storage Path:\e[0m $xnmb"

while true; do
  read -rp "$(echo -e "\e[33m\n\n[*] Is the above local storage path of the target iOS application is correct? [y/n]: \e[0m")" -e answer
  echo

  if [[ $answer =~ ^[Yy]$ ]]; then
    break
  elif [[ $answer =~ ^[Nn]$ ]]; then
	read -rp "$(echo -e "\e[93m\n\n[/] Provide the local storage path till GUID manually: \e[0m")" -e xnmb
  echo -e "\n\e[93m[*] Updated Local Storage Path:\e[0m $xnmb"
    break
  else
    echo -e "Invalid input. Please enter 'y' for yes or 'n' for no.\n"
  fi
done


Wup(){

echo -e "\e[32m\n\n[+] Deeply Scanning For Sensitive Data On All The Files Recursively\e[0m"


while true; do
  read -rp "$(echo -e "\e[33m\n\n[*] For Local Storage related vulnerabilities, do you want to use a directory already present on the iOS device (press: y)?\e[0m\n If \"n\", it will be taken from the 'input' directory? [y/n]: ")" -e answer
  echo

  if [[ $answer =~ ^[Yy]$ ]]; then

    find "$xnmb"/ -type f -exec grep -iao "$sd\|..${sdd}...\|latitude=........\|longitude=........\|secret...........\|access.key............\|access.token............\|admin.pass............\|admin.user............\|algolia.admin.key............\|algolia.api.key............\|alias.pass............\|alicloud.access.key............\|amazon.secret.access.key............\|amazonaws............\|ansible.vault.password............\|aos.key............\|api.key............\|api.key.secret............\|api.key.sid............\|api.secret............\|AIza............\|apidocs............\|apikey............\|apiSecret............\|app.debug............\|app.id............\|app.key............\|app.log.level............\|app.secret............\|appkey............\|appkeysecret............\|application.key............\|appsecret............\|appspot............\|auth.token............\|authorizationToken............\|authsecret............\|aws.access............\|aws.access.key.id............\|aws.bucket............\|aws.key............\|aws.secret............\|aws.secret.key............\|aws.token............\|AWSSecretKey............\|b2.app.key............\|bashrc.password............\|bintray.apikey............\|bintray.gpg.password............\|bintray.key............\|bintraykey............\|bluemix.api.key............\|bluemix.pass............\|browserstack.access.key............\|bucket.password............\|bucketeer.aws.access.key.id............\|bucketeer.aws.secret.access.key............\|built.branch.deploy.key............\|bx.password............\|cache.driver............\|cache.s3.secret.key............\|cattle.access.key............\|cattle.secret.key............\|certificate.password............\|ci.deploy.password............\|client.secret............\|client.zpk.secret.key............\|clojars.password............\|cloud.api.key............\|cloud.watch.aws.access.key............\|cloudant.password............\|cloudflare.api.key............\|cloudflare.auth.key............\|cloudinary.api.secret............\|cloudinary.name............\|codecov.token............\|conn.login............\|connectionstring............\|consumer.key............\|consumer.secret............\|cypress.record.key............\|database.password............\|database.schema.test............\|datadog.api.key............\|datadog.app.key............\|db.password............\|db.server............\|db.username............\|dbpasswd............\|dbpassword............\|dbuser............\|deploy.password............\|digitalocean.ssh.key.body............\|digitalocean.ssh.key.ids............\|docker.hub.password............\|docker.key............\|docker.pass............\|docker.passwd............\|docker.password............\|dockerhub.password............\|dockerhubpassword............\|dot.files............\|dotfiles............\|droplet.travis.password............\|dynamoaccesskeyid............\|dynamosecretaccesskey............\|elastica.host............\|elastica.port............\|elasticsearch.password............\|encryption.key............\|encryption.password............\|env.heroku.api.key............\|env.sonatype.password............\|eureka.awssecretkey............\|secKey...\|.......firebase....\|.forgerock..........\|.groov........\|aes_secret_key......" {} + | sed 's/:/ ==>    /' | tee ./"${adn}"/Logs/Sensitive-Data.tmp

    find "$xnmb"/ -type f -exec grep -HanoE '.......(eyJ)[%a-zA-Z0-9+/]+={0,2}.(eyJ)[%a-zA-Z0-9+/]+={0,2}' {} + | sort -u | cut -b 1-250 | sed 's/:/ ==>    /' | tee -a ./"${adn}"/Logs/Sensitive-Data.tmp

    find ./"${adn}"/input/ -not -path "*/Payload/*" -type f \( -iname "*realtime*" -o -iname "*dump*" -o -iname "*strings*" -o -iname "Info.plist" -o -iname "*keychain*" \) -exec grep -iao "$sd\|..${sdd}...\|latitude=............\|longitude=......" {} + | sed 's/:/ ==>    /' | tee -a ./"${adn}"/Logs/Sensitive-Data.tmp

    
    find ./"${adn}"/input/ -not -path "*/Payload/*" -type f \( -iname "*realtime*" -o -iname "*dump*" -o -iname "*strings*" -o -iname "Info.plist" -o -iname "*keychain*" \) -exec grep -HanoE '.......(eyJ)[%a-zA-Z0-9+/]+={0,2}.(eyJ)[%a-zA-Z0-9+/]+={0,2}' {} + | sort -u | cut -b 1-250 | grep -iva 'jsbundle' |  sed 's/:/ ==>    /' | tee -a ./"${adn}"/Logs/Sensitive-Data.tmp

    find /private/var/db/diagnostics/ -type f -exec grep -iao "$sd\|..${sdd}..." {} + |  sed 's/:/ ==>    /' | tee -a ./"${adn}"/Logs/Sensitive-Data.tmp

    cat ./"${adn}"/Logs/Sensitive-Data.tmp | sort -u > ./"${adn}"/Logs/Sensitive-Data.txt

    Iot=$(tree -f "$xnmb"/)
    echo "$Iot" | grep -ia "$sd" >> ./"${adn}"/Logs/User-Related-Data-In-Devie-Local-Storage.txt
    echo "$Iot" >> ./"${adn}"/Logs/Tree-of-Local-Storage.txt

    break
  
  elif [[ $answer =~ ^[Nn]$ ]]; then
	
    find ./"${adn}"/input/ -not -path "*/Payload/*" -type f -exec grep -iao "$sd\|..${sdd}...\|latitude=........\|longitude=........\|secret...........\|access.key............\|access.token............\|admin.pass............\|admin.user............\|algolia.admin.key............\|algolia.api.key............\|alias.pass............\|alicloud.access.key............\|amazon.secret.access.key............\|amazonaws............\|ansible.vault.password............\|aos.key............\|api.key............\|api.key.secret............\|api.key.sid............\|api.secret............\|AIza............\|apidocs............\|apikey............\|apiSecret............\|app.debug............\|app.id............\|app.key............\|app.log.level............\|app.secret............\|appkey............\|appkeysecret............\|application.key............\|appsecret............\|appspot............\|auth.token............\|authorizationToken............\|authsecret............\|aws.access............\|aws.access.key.id............\|aws.bucket............\|aws.key............\|aws.secret............\|aws.secret.key............\|aws.token............\|AWSSecretKey............\|b2.app.key............\|bashrc.password............\|bintray.apikey............\|bintray.gpg.password............\|bintray.key............\|bintraykey............\|bluemix.api.key............\|bluemix.pass............\|browserstack.access.key............\|bucket.password............\|bucketeer.aws.access.key.id............\|bucketeer.aws.secret.access.key............\|built.branch.deploy.key............\|bx.password............\|cache.driver............\|cache.s3.secret.key............\|cattle.access.key............\|cattle.secret.key............\|certificate.password............\|ci.deploy.password............\|client.secret............\|client.zpk.secret.key............\|clojars.password............\|cloud.api.key............\|cloud.watch.aws.access.key............\|cloudant.password............\|cloudflare.api.key............\|cloudflare.auth.key............\|cloudinary.api.secret............\|cloudinary.name............\|codecov.token............\|conn.login............\|connectionstring............\|consumer.key............\|consumer.secret............\|cypress.record.key............\|database.password............\|database.schema.test............\|datadog.api.key............\|datadog.app.key............\|db.password............\|db.server............\|db.username............\|dbpasswd............\|dbpassword............\|dbuser............\|deploy.password............\|digitalocean.ssh.key.body............\|digitalocean.ssh.key.ids............\|docker.hub.password............\|docker.key............\|docker.pass............\|docker.passwd............\|docker.password............\|dockerhub.password............\|dockerhubpassword............\|dot.files............\|dotfiles............\|droplet.travis.password............\|dynamoaccesskeyid............\|dynamosecretaccesskey............\|elastica.host............\|elastica.port............\|elasticsearch.password............\|encryption.key............\|encryption.password............\|env.heroku.api.key............\|env.sonatype.password............\|eureka.awssecretkey............\|.......firebase....\|.forgerock..........\|secKey...\|.groov........\|aes_secret_key......." {} + | sed 's/:/ ==>    /' | tee ./"${adn}"/Logs/Sensitive-Data.tmp

    find ./"${adn}"/input/ -not -path "*/Payload/*" -type f -exec grep -HanoE '.......(eyJ)[%a-zA-Z0-9+/]+={0,2}.(eyJ)[%a-zA-Z0-9+/]+={0,2}' {} + | sort -u | cut -b 1-250 | grep -ai "\.log\|memory\|dump\|\.db\|\.sql\|\.js\|strings.txt" |  sed 's/:/ ==>    /' | tee -a ./"${adn}"/Logs/Sensitive-Data.tmp

    find /private/var/db/diagnostics/ -type f -exec grep -iao "$sd\|..${sdd}..." {} + |  sed 's/:/ ==>    /' | tee -a ./"${adn}"/Logs/Sensitive-Data.tmp

    cat ./"${adn}"/Logs/Sensitive-Data.tmp | sort -u > ./"${adn}"/Logs/Sensitive-Data.txt
    
    Iot=$(tree -f ./"${adn}"/input/ | grep -iav "\/Payload\/\|dump")
    echo "$Iot" | grep -ia "$sd" >> ./"${adn}"/Logs/User-Related-Data-In-Devie-Local-Storage.txt
    echo "$Iot" >> ./"${adn}"/Logs/tree-of-Local-Storage.txt

    break
  
  else
    echo -e "Invalid input. Please enter 'y' for yes or 'n' for no.\n"
  fi

done


find "$nf"/ -type f -exec grep -iao "$sd\|..${sdd}...\|latitude=........\|longitude=........\|secret...........\|access.key............\|access.token............\|admin.pass............\|admin.user............\|algolia.admin.key............\|algolia.api.key............\|alias.pass............\|alicloud.access.key............\|amazon.secret.access.key............\|amazonaws............\|ansible.vault.password............\|aos.key............\|api.key............\|api.key.secret............\|api.key.sid............\|api.secret............\|AIza............\|apidocs............\|apikey............\|apiSecret............\|app.debug............\|app.id............\|app.key............\|app.log.level............\|app.secret............\|appkey............\|appkeysecret............\|application.key............\|appsecret............\|appspot............\|auth.token............\|authorizationToken............\|authsecret............\|aws.access............\|aws.access.key.id............\|aws.bucket............\|aws.key............\|aws.secret............\|aws.secret.key............\|aws.token............\|AWSSecretKey............\|b2.app.key............\|bashrc.password............\|bintray.apikey............\|bintray.gpg.password............\|bintray.key............\|bintraykey............\|bluemix.api.key............\|bluemix.pass............\|browserstack.access.key............\|bucket.password............\|bucketeer.aws.access.key.id............\|bucketeer.aws.secret.access.key............\|built.branch.deploy.key............\|bx.password............\|cache.driver............\|cache.s3.secret.key............\|cattle.access.key............\|cattle.secret.key............\|certificate.password............\|ci.deploy.password............\|client.secret............\|client.zpk.secret.key............\|clojars.password............\|cloud.api.key............\|cloud.watch.aws.access.key............\|cloudant.password............\|cloudflare.api.key............\|cloudflare.auth.key............\|cloudinary.api.secret............\|cloudinary.name............\|codecov.token............\|conn.login............\|connectionstring............\|consumer.key............\|consumer.secret............\|cypress.record.key............\|database.password............\|database.schema.test............\|datadog.api.key............\|datadog.app.key............\|db.password............\|db.server............\|db.username............\|dbpasswd............\|dbpassword............\|dbuser............\|deploy.password............\|digitalocean.ssh.key.body............\|digitalocean.ssh.key.ids............\|docker.hub.password............\|docker.key............\|docker.pass............\|docker.passwd............\|docker.password............\|dockerhub.password............\|dockerhubpassword............\|dot.files............\|dotfiles............\|droplet.travis.password............\|dynamoaccesskeyid............\|dynamosecretaccesskey............\|elastica.host............\|elastica.port............\|elasticsearch.password............\|encryption.key............\|encryption.password............\|env.heroku.api.key............\|env.sonatype.password............\|eureka.awssecretkey..............\|secKey...\|.......firebase....\|.forgerock..........\|.groov........" {} + | sed 's/:/ ==>    /' | tee ./"${adn}"/Logs/HCode-Sensitive-Data.tmp


find ./"${adn}"/input/ -not -path "*/Payload/*" -type f -iname "Info.plist" -exec grep -iao "$sd\|..${sdd}...\|latitude=............\|longitude=............\|secret...........\|access.key............\|access.token............\|admin.pass............\|admin.user............\|algolia.admin.key............\|algolia.api.key............\|alias.pass............\|alicloud.access.key............\|amazon.secret.access.key............\|amazonaws............\|ansible.vault.password............\|aos.key............\|api.key............\|api.key.secret............\|api.key.sid............\|api.secret............\|AIza............\|apidocs............\|apikey............\|apiSecret............\|app.debug............\|app.id............\|app.key............\|app.log.level............\|app.secret............\|appkey............\|appkeysecret............\|application.key............\|appsecret............\|appspot............\|auth.token............\|authorizationToken............\|authsecret............\|aws.access............\|aws.access.key.id............\|aws.bucket............\|aws.key............\|aws.secret............\|aws.secret.key............\|aws.token............\|AWSSecretKey............\|b2.app.key............\|bashrc.password............\|bintray.apikey............\|bintray.gpg.password............\|bintray.key............\|bintraykey............\|bluemix.api.key............\|bluemix.pass............\|browserstack.access.key............\|bucket.password............\|bucketeer.aws.access.key.id............\|bucketeer.aws.secret.access.key............\|built.branch.deploy.key............\|bx.password............\|cache.driver............\|cache.s3.secret.key............\|cattle.access.key............\|cattle.secret.key............\|certificate.password............\|ci.deploy.password............\|client.secret............\|client.zpk.secret.key............\|clojars.password............\|cloud.api.key............\|cloud.watch.aws.access.key............\|cloudant.password............\|cloudflare.api.key............\|cloudflare.auth.key............\|cloudinary.api.secret............\|cloudinary.name............\|codecov.token............\|conn.login............\|connectionstring............\|consumer.key............\|consumer.secret............\|cypress.record.key............\|database.password............\|database.schema.test............\|datadog.api.key............\|datadog.app.key............\|db.password............\|db.server............\|db.username............\|dbpasswd............\|dbpassword............\|dbuser............\|deploy.password............\|digitalocean.ssh.key.body............\|digitalocean.ssh.key.ids............\|docker.hub.password............\|docker.key............\|docker.pass............\|docker.passwd............\|docker.password............\|dockerhub.password............\|dockerhubpassword............\|dot.files............\|dotfiles............\|droplet.travis.password............\|dynamoaccesskeyid............\|dynamosecretaccesskey............\|elastica.host............\|elastica.port............\|elasticsearch.password............\|encryption.key............\|encryption.password............\|env.heroku.api.key............\|env.sonatype.password............\|eureka.awssecretkey.............\|secKey...\|.......firebase....\|.forgerock..........\|.groov........" {} + | sed 's/:/ ==>    /' | tee -a ./"${adn}"/Logs/HCode-Sensitive-Data.tmp

cat ./"${adn}"/Logs/HCode-Sensitive-Data.tmp | sort -u > ./"${adn}"/Logs/HCode-Sensitive-Data.txt

}

Cytool(){}

echo -e "\n\n\e[33m\n[*] Testing Via Cycript tool.\e[0m"

echo "alertView = [[UIAlertView alloc] initWithTitle:'iOS Buster <3' message:'Made By DarkLotusKDB' delegate:nil cancelButtonTitle:'Alright' otherButtonTitles:nil]" | cycript -p $aid
echo "[alertView show]" | cycript -p $aid
}


Antid(){
echo -e "\e[32m\n\n[+] Missing Anti-Debugging Mechanism\e[0m"

#echo -e "\e[33m\n[*] Please provide few words from the target app name: \e[0m"
#read anm

echo -e "\e[33m\n[*] Verifying via lldb tool.\e[0m"
lldb -p $aid --batch -o "register read" -o "exit" | tee ./"${adn}"/Logs/Missing-Anti-Debugging-Mechanism.txt

echo -e "\n"

while true; do
  read -rp "$(echo -e "\e[33m\n\n[*] Able to get valid output from lldb tool? [y/n]: \e[0m")" -e answer
  echo

  if [[ $answer =~ ^[Yy]$ ]]; then
	echo -e "\e[31m\n[-] Vulnerable: Missing Anti-Debugging Mechanism\e[0m"
    break
  elif [[ $answer =~ ^[Nn]$ ]]; then
	echo -e "\e[33m\n[#] Not Vulnerable\e[0m" 
    break
  else
    echo -e "Invalid input. Please enter 'y' for yes or 'n' for no.\n"
  fi
done
}



Sinfo(){
echo -e "\e[32m\n\n[+] Checking Symbol Information\e[0m"
echo -e "\n$nm"
echo -e "\nKamal:~ root#\e[93m nm "$nb"\e[0m"
Io=$(nm "$nm")

echo "$Io" > ./"${adn}"/Logs/Checking-Symbol-Information.txt
echo "$Io" | head -30

echo -e "\e[33m\n[*] Filtering out the 'T' from the above output\e[0m"
echo -e "\nKamal:~ root#\e[93m nm "$nb" | grep ' T '\e[0m"
echo "$Io" | grep ' T ' | head -30

Id=$(echo "$Io" | grep ' T ' | wc -l)

if [ $Id -ge 4 ] ; then 
	echo -e "\e[31m\n[*] Additional Observation: Checking Symbol Information\e[0m"
else
	echo -e "\e[33m\n[#] Not Vulnerable\e[0m"
fi
}



Aslr(){
echo -e "\e[32m\n\n[+] PIE ASLR Not Implemented\e[0m\n"
#echo "$nm"
Io=$(otool -hv "$nm")

echo -e "\nKamal:~ root#\e[93m otool -hv "$nb"\e[0m"
echo "$Io" | tee ./"${adn}"/Logs/PIE-ASLR-Not-Implemented.txt

if echo "$Io" | grep 'PIE' &> /dev/null; then
	echo -e  "\e[33m\n[#] Not Vulnerable\e[0m"
else
	echo -e "\e[31m\n[-] Vulnerable: PIE ASLR Not Implemented\e[0m"
fi

}



Arc(){
echo -e "\e[32m\n\n[+] ARC Not Enabled\e[0m"
echo -e "\n$nm"

Io=$(otool -I -v "$nm" | grep -i "_objc_")

echo -e "\nKamal:~ root#\e[93m otool -I -v "$nb" | grep -i '_objc_'\e[0m"

echo "$Io" | head -5
echo "$Io" > ./"${adn}"/Logs/ARC-Not-Enabled.txt

if echo "$Io" | grep '_objc_' &> /dev/null; then
	echo -e  "\e[33m\n[#] Not Vulnerable\e[0m"
else
	echo -e "\e[31m\n[-] Vulnerable: ARC Not Enabled\e[0m"
fi

}



Stcan(){
echo -e "\e[32m\n\n[+] Stack Canaries Not Enabled\e[0m"
echo -e "\n$nm"

Io=$(otool -I -v "$nm" | grep -i stack)

echo -e "\nKamal:~ root#\e[93m otool -I -v "$nb" | grep -i stack\e[0m"

echo "$Io" | head -5
echo "$Io" > ./"${adn}"/Logs/Stack-Canaries-Not-Enabled.txt

if echo "$Io" | grep 'stack' &> /dev/null ; then
	echo -e  "\e[33m\n[#] Not Vulnerable\e[0m"
else
	echo -e "\e[31m\n[-] Vulnerable: Stack Canaries Not Enabled\e[0m"
fi
}



Cdova(){
echo -e "\e[32m\n\n[+] Use Of Vulnerable Cordova or PhoneGap Framework Version\e[0m"
#Io=$(find "$nf"/ -type f -exec grep -i "var PLATFORM" {} + | grep -i "PLATFORM_VERSION_BUILD_LABEL" | sed 's/:/ ==>  /')

Io=$(find "$nf"/ -type f -exec grep -i "var PLATFORM_VERSION_BUILD_LABEL" {} + | sed 's/:/ ==>  /')

echo "$Io" | tee ./"${adn}"/Logs/Use-Of-Vulnerable-Cordova-or-PhoneGap-Framework-Version.txt

if echo "$Io" | grep -i "VERSION" &> /dev/null ; then
	echo -e  "\e[33m\n[*] Possible: Use Of Vulnerable Cordova or PhoneGap Framework Version\e[0m"
else
	echo -e "\e[33m\n[#] Cordova file not found, please confirm it manually.\e[0m"
fi
}




Ipp(){
echo -e "\e[32m\n\n[+] Internal IP Discovered\e[0m"

echo -e "\e[33m\n[*] Searching for IPv4:\e[0m"

find "$nf"/ -type f -exec grep -Eaio '(http|https)://[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+' {} + | sort -u | sed 's/:/ ==>   /' | tee ./"${adn}"/Logs/Internal-IP-Discovered-IPv4.txt

Io=$(find "$nf"/ -type f -exec grep -a -o '..[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}...' {} + | sort -u | sed 's/:/ ==>  /' | grep -ia -v '\.png\|\.ttf\|\.jpeg\|\.jpg\|\.log\|strings\.txt\|dump\.data\|memorydump\|>  0\|\.0\|>  1\.\|>  2\.\|>  3\.') 

# grep -Ea '\b((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)(\.|$)){4}\b')

#echo "$Io" | head -30


if echo "$Io" | grep -va '127.0.0.1\|10...\.' | grep -ia ' ..10\.\| ..172\.\| ..192\.\| ..127\.\| ..169\.254\.' ; then

	echo -e  "\e[31m\n[*] Possible: Internal IP Discovered\e[0m"
else
  echo "$Io" | grep -iva ' 10\.\| 172\.\| 192\.\| 127\.\| 169\.254\.\|127.0.0.1\|>  0\|\.0\|>  1\.\|>  2\.\|>  3\.\|>  4\.\|>  5\.\|>  6\.\|>  7\.\|\.svg\|blob' | head -30
	echo -e "\e[33m\n[*] Info: Internal IP Discovered (Check the "6-Internal-IP-Discovered-IPv4.txt" log file)\e[0m"
fi

echo "$Io" >> ./"${adn}"/Logs/Internal-IP-Discovered-IPv4.txt

echo -e "\e[33m\n[*] Searching for IPv6:\e[0m"
Io=$(find "$nf"/ -type f -exec grep -iao '(([0-9a-fA-F]{1,4}:){7,7}[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,7}:|([0-9a-fA-F]{1,4}:){1,6}:[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,5}(:[0-9a-fA-F]{1,4}){1,2}|([0-9a-fA-F]{1,4}:){1,4}(:[0-9a-fA-F]{1,4}){1,3}|([0-9a-fA-F]{1,4}:){1,3}(:[0-9a-fA-F]{1,4}){1,4}|([0-9a-fA-F]{1,4}:){1,2}(:[0-9a-fA-F]{1,4}){1,5}|[0-9a-fA-F]{1,4}:((:[0-9a-fA-F]{1,4}){1,6})|:((:[0-9a-fA-F]{1,4}){1,7}|:)|fe80:(:[0-9a-fA-F]{0,4}){0,4}%[0-9a-zA-Z]{1,}|::(ffff(:0{1,4}){0,1}:){0,1}((25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])\.){3,3}(25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])|([0-9a-fA-F]{1,4}:){1,4}:((25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])\.){3,3}(25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9]))' {} + | sort -u | sed 's/:/ ==>        /')
echo "$Io" | head -30
echo "$Io" > ./"${adn}"/Logs/Internal-IP-Discovered-IPv6.txt

#echo -e  "\e[31m\n[*] Possible: Internal IP Discovered\e[0m"
}



Uhtp(){
echo -e "\e[32m\n\n[+] Searching for URLs without SSL and protocols like ssh, file, ftp, ldap, etc\e[0m"
Pcall="ftp ssh file ldap rdp http"

Io=$(for Pcl in $Pcall; do find "$nf"/ -type f -exec grep -Eao "${Pcl}://[a-zA-Z0-9./?=_%:-]*" {} + | grep -ia -v "\.png\|\.jpg\|jquery\|adobe\|microsoft\|w3.org\|digicert\|cdn\|verisign\|apple\|fontfont\|license\|readme\|baidu\|apache\|ocsp\|sourceforge.net\|\.log\|dump.data\|strings.txt\|twitter.com\|ydietitian.com\|sacks.com.au\|w.day.com\|purl.org\|fontello.com\|lettersfromsweden\|wikipedia\|nonblocking\|wiki\|ecmascript\|cordova.js\|feross\|github\|twitter\|facebook\|instagram\|getfirebug\|jsperf\|cordova\|cssreset\|meyerweb" | sort -u | sed 's/:/ ==>        /'; done)

echo "$Io" | head -30
echo "$Io" > ./"${adn}"/Logs/HTTP-URLs-Without-SSL.txt

echo -e  "\e[33m\n[*] Additional Observation: HTTP URLs Without SSL\e[0m"
}



Nlv(){
: ' dead code
echo -e "\e[32m\n\n[+] Null Initialization Vector\e[0m"
echo -e "\n$nm"
#Io=$(find ./"${adn}"/input -type f -exec grep -iao 'AESEncryptWithKey\|CryptorCreate\|Encrypt\|decrypt' {} + | grep -v "\.log\|\.js\|dump\.data\|strings.txt\|memorydump" | sort -u)
Io=$(cat "$nm" | grep -iao 'AESEncryptWithKey\|CryptorCreate\|Encrypt\|decrypt' | sort -u)
echo "$Io" | head -30
echo "$Io" > ./"${adn}"/Logs/Null-Initialization-Vector.txt
echo "$Io" | cut -d ':' -f 1 | sort -u > nlv.tmp
f=0
while IFS= read i; do
q=$(cat "$nm" | grep -ia 'AESEncryptWithKey\|CryptorCreate\|Encrypt\|decrypt')
if echo "$q" | grep -ia ',null ,\|,null,\|=null\|"null"' &> /dev/null ; then
        echo -e "\e[33m\n[*] Found in:\e[0m $i" && f=1
fi
done < nlv.tmp
if [[ $f -eq 1 ]]; then
        echo -e  "\e[33m\n[*] Possible: Null Initialization Vector\e[0m"
else
        echo -e "\e[33m\n[#] Not Vulnerable\e[0m"
fi
rm -rf nlv.tmp
'



echo -e "\e[32m\n\n[+] Null Initialization Vector\e[0m"
echo -e "\n$nm"
#Io=$(find ./"${adn}"/input -type f -exec grep -iao 'AESEncryptWithKey\|CryptorCreate\|Encrypt\|decrypt' {} + | grep -v "\.log\|\.js\|dump\.data\|strings.txt\|memorydump" | sort -u)

Io=$(otool -I -v "$nm" | grep -i 'AESEncryptWithKey\|CryptorCreate\|Encrypt\|decrypt')

echo "$Io" | head -30
echo "$Io" > ./"${adn}"/Logs/Null-Initialization-Vector.txt
#echo "$Io" | cut -d ':' -f 1 | sort -u > nlv.tmp


if echo "$nm" | grep -i 'AESEncryptWithKey\|CryptorCreate\|Encrypt\|decrypt' &> /dev/null; then
        echo -e  "\e[33m\n[*] Possible: Null Initialization Vector\e[0m"
else
        echo -e "\e[33m\n[#] Not Vulnerable\e[0m"
fi


#f=0


#while IFS= read i; do
#q=$(cat "$nm" | grep -ia 'AESEncryptWithKey\|CryptorCreate\|Encrypt\|decrypt')

#if cat "$nm" | grep -iao 'AESEncryptWithKey.............................................................................\|CryptorCreate.............................................................................\|Encrypt.............................................................................\|decrypt.......................................................................' | grep -ia 'null' &> /dev/null ; then
#        echo -e "\e[33m\n[*] Found in:\e[0m $i" && f=1
#fi
#done < nlv.tmp

#if [[ $f -eq 1 ]]; then
#        echo -e  "\e[33m\n[*] Possible: Null Initialization Vector\e[0m"
#else
#        echo -e "\e[33m\n[#] Not Vulnerable\e[0m"
#fi

#rm -rf nlv.tmp


}



Rann(){
echo -e "\e[32m\n\n[+] Use Of Insecure Random Function\e[0m"
#Io=$(find ./"${adn}"/input -type f -exec grep -iao 'random\|arc4random' {} + | sort -u | sed 's/:/ ==>   /' | grep -v 'rAnd\|jrxml\|\.svg\|\.css\|\.png\|\.js\|\.log\|strings.txt\|dump.data')
#Io=$(cat "$nm" | grep -iao 'arc4random\|random' | sort -u )
#echo "$Io" | head -10
#echo "$Io" > ./"${adn}"/Logs/Use-Of-Insecure-Random-Function.txt

echo -e "\e[33m\n[*] Results From Otool\e[0m"

Io=$(otool -I -v "$nm" | grep -i 'arc4random\|random\|rand')

echo -e "\nKamal:~ root#\e[93m otool -I -v "$nb" | grep -i 'arc4random\|random\|rand'\e[0m"

echo "$Io" | sort -u | head -30
echo "$Io" > ./"${adn}"/Logs/Use-Of-Insecure-Random-Function.txt

if echo "$Io" | grep -i "random" &> /dev/null ; then
	echo -e  "\e[33m\n[*] Possible: Use Of Insecure Random Function\e[0m"
else
	echo -e "\e[33m\n[#] Not Vulnerable\e[0m"
fi
}



Sndata(){

#ifile=./sensitive-data.txt


echo -e "\e[32m\n\n[+] Performance Sensitive Data Related Test-Cases\e[0m"

#grep -HanoE '(eyJ|YTo|Tzo|PD[89]|aHR0cHM6L|aHR0cDo|rO0)[%a-zA-Z0-9+/]+={0,2}' -r ./input/* | sed 's/:/ ==>        /' | tee sd.log
#grep -HanoE "\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,6}\b" -r ./input/* | grep -v "\.png$\|2x.ktx" | sed 's/:/ ==>    /' | tee -a sd.log

#find ./"${adn}"/input/ -not -path "*/Payload/*" -type f -exec grep -iao "$sd\|latitude=............\|longitude=......" {} + | sed 's/:/ ==>    /' > ./"${adn}"/Logs/Sensitive-Data.txt

cat ./"${adn}"/Logs/Sensitive-Data.txt | head -30


if cat ./"${adn}"/Logs/Sensitive-Data.txt | grep -ia "$sd" &> /dev/null ; then
	echo -e  "\e[31m\n[*] Info: Sensitive Data Found (Check the "Sensitive-Data.txt" log file)\e[0m"
else
	echo -e "\e[33m\n[*] Info: Sensitive Data Found (Not found any word from keywords.txt data, Check the "Sensitive-Data.txt" log file)\e[0m"
fi


echo -e "\e[33m\n[*] User Related Data Cached In WebView\e[0m"
Io=$(cat ./"${adn}"/Logs/Sensitive-Data.txt | grep -ia "Cache.db\|cache") 

echo "$Io" > ./"${adn}"/Logs/User-Related-Data-Cached-In-WebView.txt

echo "$Io" | head -30
if echo "$Io" | grep -ia "$sd" &> /dev/null ; then
	echo -e  "\e[31m\n[-] Vulnerable: User Related Data Cached In WebView\e[0m"
  else
	echo -e "\n[#] Not Vulnerable (Not found any word from keywords.txt data)\n"
fi
	
echo -e "\e[33m\n[*] User Related Data Stored In Plist\e[0m"
Io=$(cat ./"${adn}"/Logs/Sensitive-Data.txt | grep -ia "plist")

echo "$Io" > ./"${adn}"/Logs/User-Related-Data-Stored-In-Plist.txt

echo "$Io" | head -30
if echo "$Io" | grep -ia "$sd" &> /dev/null ; then
	echo -e  "\e[31m\n[-] Vulnerable: User Related Data Stored In Plist\e[0m"
else
	echo -e "\n[#] Not Vulnerable (Not found any word from keywords.txt data)\n"
fi
	
echo -e "\e[33m\n[*] User Related Data Captured In System Logs\e[0m"
Io=$(cat ./"${adn}"/Logs/Sensitive-Data.txt | grep -ia "\.log\|realtime\|db.diagnostics")

echo "$Io" > ./"${adn}"/Logs/User-Related-Data-Captured-In-System-Logs.txt

echo "$Io" | head -30
if echo "$Io" | grep -ia "$sd" &> /dev/null ; then
	echo -e  "\e[31m\n[-] Vulnerable: User Related Data Captured In System Logs\e[0m"
  else
	echo -e "\n[#] Not Vulnerable (Not found any word from keywords.txt data)\n"
fi
	
echo -e "\e[33m\n[*] Login Credential Found In Device Memory Dump\e[0m"
Io=$(cat ./"${adn}"/Logs/Sensitive-Data.txt | grep -ia "memory\|dump\|strings.txt")

echo "$Io" > ./"${adn}"/Logs/Login-Credential-Found-In-Device-Memory-Dump.txt

echo "$Io" | head -30

if echo "$Io" | grep -ia "$sd" &> /dev/null ; then
  echo -e "\n"
	while true; do
  echo -e "\e[33m"
  read -rp "Based on the above output, please verify the presence of both username and password. [y/n]: " -e answer
  echo -e "\e[0m"
  
    if [[ $answer =~ ^[Yy]$ ]]; then
	  echo -e  "\e[31m\n[-] Vulnerable: Login Credential Found In Device Memory Dump\e[0m"
      break
    elif [[ $answer =~ ^[Nn]$ ]]; then
	  echo -e "\e[33m\n[*] Additional Observation: Login Credential Found In Device Memory Dump\e[0m"
      break
    else
      echo -e "Invalid input. Please enter 'y' for yes or 'n' for no.\n"
    fi
  done
  else
	  echo -e "\n[#] Not Vulnerable (Not found any word from keywords.txt data)\n"
fi


echo -e "\e[33m\n[*] User Related Data Stored In Device Keychain\e[0m"
Io=$(cat ./"${adn}"/Logs/Sensitive-Data.txt | grep -ia "keychain")

echo "$Io" > ./"${adn}"/Logs/User-Related-Data-Stored-In-Device-Keychain.txt

echo "$Io" | head -30
if echo "$Io" | grep -ia "$sd" &> /dev/null ; then
	echo -e  "\e[31m\n[-] Vulnerable: User Related Data Stored In Device Keychain\e[0m"
  else
	echo -e "\n[#] Not Vulnerable (Not found any word from keywords.txt data)\n"
fi

echo -e "\e[33m\n[*] User Related Data In Devie Local Storage\e[0m"
#Io=$(cat ./"${adn}"/Logs/Sensitive-Data.txt | grep -ia "metadata\|manifest\|\.settings\|\.sql\|\.db\|\.localstorage")
Io=$(cat ./"${adn}"/Logs/Sensitive-Data.txt | grep -iav "plist\|keychain\|memory\|dump\|strings.txt\|\.log\|realtime\|Cache.db\|cache\|db.diagnostics")

echo "$Io" > ./"${adn}"/Logs/User-Related-Data-In-Devie-Local-Storage.txt

echo "$Io" | head -30

if echo "$Io" | grep -ia "$sd" &> /dev/null ; then
	echo -e  "\e[31m\n[-] Vulnerable: User Related Data In Devie Local Storage\e[0m"
  else
	echo -e "\n[#] Not Vulnerable (Not found any word from keywords.txt data)\n"
fi	

echo -e "\n"

#Iot=$(tree -f ./"${adn}"/input/ | grep -iav "\/Payload\/\|dump")
#echo "$Io" >> ./"${adn}"/Logs/Sensitive-Data.txt 

echo -e "\e[33m\n[/] Searching for Cookies.binarycookies file and sensitive data as name of the file or directory in local storage\e[0m"
echo -e "Utilize the Binary Cookie Reader tool (https://github.com/as0ler/BinaryCookieReader) to extract the content in its regular form.\n"

echo "$Iot" | grep -ia cookie | tee -a ./"${adn}"/Logs/User-Related-Data-In-Devie-Local-Storage.txt

echo -e "\n"

if echo "$Iot" | grep -ia "$sd" &> /dev/null ; then
  echo "$Iot" | grep -ia "$sd" | head -30
	echo -e  "\e[31m\n[-] Vulnerable: User Related Data In Devie Local Storage\e[0m"
  else
	echo -e "\n[#] Not Vulnerable (Not found any word from keywords.txt data)\n"
fi	

echo -e  "\e[33m\n[*] Info: Must check the file ./"${adn}"/Logs/Tree-of-Local-Storage.txt\e[0m"

}


HcodedS(){
echo -e "\e[32m\n\n[+] Sensitive Data Hard-Coded In Client-side Code\e[0m"


#find "$nf"/ -type f -exec grep -iao "$sd\|latitude=............\|longitude=......" {} + | sed 's/:/ ==>    /' > ./"${adn}"/Logs/HCode-Sensitive-Data.txt

#cat ./"${adn}"/Logs/HCode-Sensitive-Data.txt | sort -u | head -30

#find "$nf"/ -type f -exec grep -HanoE '.......(eyJ)[%a-zA-Z0-9+/]+={0,2}.(eyJ)[%a-zA-Z0-9+/]+={0,2}' {} + | sort -u | cut -b 1-250 | sed 's/:/ ==>    /' >> ./"${adn}"/Logs/HCode-Sensitive-Data.txt



if cat ./"${adn}"/Logs/HCode-Sensitive-Data.txt | grep -ia "$sd" &> /dev/null ; then
  cat ./"${adn}"/Logs/HCode-Sensitive-Data.txt | grep -ia "$sd" | head -30 | tee ./"${adn}"/Logs/Sensitive-Data-Hard-Coded-In-Client-side-Code.txt
	echo -e  "\e[31m\n[-] Vulnerable: Sensitive Data Hard-Coded In Client-side Code\e[0m"
else
	echo -e "\e[33m\n[*] Info: Sensitive Data Hard-Coded In Client-side Code (Not found any word from keywords.txt data, Check the "HCode-Sensitive-Data.txt" log file)\e[0m"
fi

}


Hcode(){
echo -e "\e[32m\n\n[+] Cipher Initialized with a Hard-coded Key in Mobile Client-side Code\e[0m"
Io=$(find "$nf"/ -type f -exec grep -iao "CCPassword............................\|enckey............................\|encryption............................\|this\.password............................\|encrypt............................\|decrypt............................\|decryption............................\|deckey............................\| iv......................" {} + | grep -ia -v "\.gif\|\.png\|\.jpg\|\.jpeg\|\.css\|\.ico\|\.pdf\|\.html\|\.log\|dump\|strings\.txt" | sort -u | sed 's/:/ ==>   /')

echo "$Io" | head -30
echo "$Io" > ./"${adn}"/Logs/Cipher-Initialized-with-a-Hard-coded-Key-in-Mobile-Client-side-Code.txt

echo -e  "\e[33m\n[*] Info: Possible Cipher Related Hardcoded Secrets (Check the 'Cipher-Initialized-with-a-Hard-coded-Key-in-Mobile-Client-side-Code.txt' log file)\e[0m"

}


Trns(){
#iinfo=$1
echo -e "\e[32m\n\n[+] ATS Configuration Is Insecure\e[0m"
echo -e "\n$nf/"

Io=$(cat "$iinfo" | grep -i -A2 'NSAllowsArbitraryLoads\|NSExceptionAllowsInsecureHTTPLoads')

echo -e "\nKamal:~ root#\e[93m cat Info.plist | grep -i -A2 'NSAllowsArbitraryLoads\|NSExceptionAllowsInsecureHTTPLoads'\e[0m"

echo "$Io" | tee ./"${adn}"/Logs/ATS-Configuration-Is-Insecure.txt

Io1=$(cat "$iinfo" | grep -i -A1 "NSAllowsArbitraryLoads")
Io2=$(cat "$iinfo" | grep -i -A1 "NSExceptionAllowsInsecureHTTPLoads")

if echo "$Io1" | grep -i "true" &> /dev/null ; then
	echo -e  "\e[31m\n[-] Vulnerable: ATS Configuration Is Insecure\e[0m"
elif echo "$Io2" | grep -i "true" &> /dev/null ; then
	echo -e  "\e[33m\n[*] Possible: ATS Configuration Is Insecure\e[0m"
else
	echo -e "\e[33m\n[#] Not Vulnerable\e[0m"
fi
}



Mos(){
#iinfo=$1
echo -e "\e[32m\n\n[+] Application Minimum OS Version Is Vulnerable\e[0m"
echo -e "\n$nf/"

echo -e "\nKamal:~ root#\e[93m cat Info.plist | grep -i -A1 'MinimumOSVersion'\e[0m"

cat "$iinfo" | grep -i -A1 ">MinimumOSVersion"

Io=$(cat "$iinfo" | grep -i -A1 ">MinimumOSVersion" | head -2 | grep string | tr -d "</string>" | cut -d "." -f 1 | awk '{ print substr( $0, length($0)-1 ) }')
echo "$Io" > ./"${adn}"/Logs/Application-Minimum-OS-Version-Is-Vulnerable.txt

if [ $Io -ge 15 ] ; then
	echo -e  "\e[33m\n[#] Not Vulnerable\e[0m"
else
  mos="$Io"
	echo -e "\e[31m\n[-] Vulnerable: Application Minimum OS Version Is Vulnerable\e[0m"
fi
}



Cao(){
echo -e "\e[32m\n\n[+] Misconfigured Access Origin In Cordova Or PhoneGap\e[0m"
Io=$(find "$nf"/ -type f -iname *.xml -exec grep -ia '<access origin="\*"' {} + | sed 's/:/ ==>   /')
echo "$Io" > ./"${adn}"/Logs/Misconfigured-Access-Origin-In-Cordova-Or-PhoneGap.txt
echo "$Io"

if echo "$Io" | grep -i 'access origin' &> /dev/null ; then
	echo -e  "\e[31m\n[-] Vulnerable: Misconfigured Access Origin In Cordova Or PhoneGap\e[0m"
else
	echo -e "\e[33m\n[#] Not Vulnerable\e[0m"
fi
}


Bobf(){
echo -e "\e[32m\n\n[+] Application Binary Is Not Obfuscated\e[0m"
echo "$nm"
Io=$(otool -l "$nm" | grep -A4 LC_ENCRYPTION_INFO)
echo -e "\nKamal:~ root#\e[93m otool -l "$nb" | grep -A4 'LC_ENCRYPTION_INFO'\e[0m"
#echo "$Io"
echo -e "\nChecking for Encryption:\n"
echo "$Io" > ./"${adn}"/Logs/Application-Binary-Is-Not-Obfuscated.txt
echo "$Io" | head -5

if echo "$Io" | grep -i "cryptid 0" &> /dev/null; then 
	echo -e "\e[31m\n[*] Possible: Application Binary Is Not Obfuscated\e[0m"
else
	echo -e "\e[33m\n[#] Not Vulnerable\e[0m"
fi
}



Ikey(){

  echo -e "\e[32m\n\n[+] Security Access Control Missing From iOS Keychain\e[0m"

if ls ./"${adn}"/input | grep -i 'keychain' &> /dev/null ; then
	Io=$(ls ./"${adn}"/input | grep -i keychain)
	echo -e "\e[33m\n[*] File Found: "$Io"\e[0m\n"
	Iin=$(cat "./"${adn}"/input/$Io" | grep -i -A2 '"access_control": "None"')

		if cat "./"${adn}"/input/$Io" | grep -i '"access_control": "None"' &> /dev/null ; then
			echo "$Iin" > ./"${adn}"/Logs/Security-Access-Control-Missing-From-iOS-Keychain.txt
      echo -e "\n\nKamal:~ root#\e[93m cat keychain.json | grep -i '\"access_control\": \"None\"'\e[0m"
			echo "$Iin" | head -30
			
			echo -e  "\e[31m\n[-] Vulnerable: Security Access Control Missing From iOS Keychain\e[0m"
		else
			echo -e "\e[33m\n[#] Not Vulnerable\e[0m"
	fi

	else
        	echo -e "\e[33m\n[*] Not Found: keychain.json file" | tee ./"${adn}"/Logs/Security-Access-Control-Missing-From-iOS-Keychain.txt
fi
}



#relaunch
Wxss(){

echo -e "\e[32m\n\n[+] Integrity Check Not Implemented On WebView Content\e[0m"


Io=$(find "$xnm" -iname *.htm*)
xsp=$(echo "$Io")
echo "$Io" > ./"${adn}"/Logs/Integrity-Check-Not-Implemented-On-WebView-Content-Payload.txt


Ioa=$(find "$xnmb" -iname *.htm*)
xsl=$(echo "$Ioa")
echo "$Ioa" > ./"${adn}"/Logs/Integrity-Check-Not-Implemented-On-WebView-Content-Local_Storage.txt


if echo "$Io" | grep -i '.htm' ; then
 
	echo -e "\e[33m\n[*] Found HTML files in Application directory, now injecting <script>alert("DarkLotusKDB")</script>\e[0m\n"
  while IFS= read html ; do
	  echo '<script>alert("DarkLotusKDB")</script>' | tee -a "$html" &> /dev/null
  done < ./"${adn}"/Logs/Integrity-Check-Not-Implemented-On-WebView-Content-Payload.txt
  
  echo -e "\e[33m\n[*] Relaunch the application.\e[0m\n"

while true; do
 echo -e "\e[33m"
  read -rp "If it is found, did the alert box appear? [y/n]: " -e answer
  echo -e "\e[0m"

  if [[ $answer =~ ^[Yy]$ ]]; then
	echo -e "\e[31m\n[-] Vulnerable: Integrity Check Not Implemented On WebView Content\e[0m\n"

	while true; do
   echo -e "\e[33m"
  	read -rp "Do you want to remove the XSS payload from the HTML file? [y/n]: " -e answer
    echo -e "\e[0m\n"
  	echo

  if [[ $answer =~ ^[Yy]$ ]]; then
    while IFS= read xss ; do
   	sed -i 's/<script>alert("DarkLotusKDB")<\/script>//g' "$xss" &> /dev/null
    done < ./"${adn}"/Logs/Integrity-Check-Not-Implemented-On-WebView-Content-Payload.txt
    
	echo -e "XSS Payload is removed.\n"
    break
  elif [[ $answer =~ ^[Nn]$ ]]; then
    echo "Okay, Not removing the XSS payload."
    break
  else
    echo -e "Invalid input. Please enter 'y' for yes or 'n' for no.\n"
  fi
	done

    break
  elif [[ $answer =~ ^[Nn]$ ]]; then
	echo -e "\e[33m\n[#] Not Vulnerable\e[0m" 
    break
  else
    echo -e "Invalid input. Please enter 'y' for yes or 'n' for no.\n"
  fi
done

else
	echo "Not Found in Application directory"
fi




if echo "$Ioa" | grep -i '.htm' ; then
	echo -e "\e[33m\n[*] Found HTML files in Local Storage, now injecting <script>alert("DarkLotusKDB")</script>\e[0m\n"
	 while IFS= read html ; do
	  echo '<script>alert("DarkLotusKDB")</script>' | tee -a "$html" &> /dev/null
  done < ./"${adn}"/Logs/Integrity-Check-Not-Implemented-On-WebView-Content-Local_Storage.txt

echo -e "\e[33m\n[*] Relaunch the application.\e[0m\n"

while true; do
 echo -e "\e[33m"
  read -rp "If it is found, did the alert box appear? [y/n]: " -e answer
  echo -e "\e[0m"

  if [[ $answer =~ ^[Yy]$ ]]; then
	echo -e "\e[31m\n[-] Vulnerable: Integrity Check Not Implemented On WebView Content\e[0m\n"

	while true; do
   echo -e "\e[33m"
  	read -rp "Do you want to remove the XSS payload from the HTML file? [y/n]: " -e answer
    echo -e "\e[0m\n"
  	echo

  if [[ $answer =~ ^[Yy]$ ]]; then
	
  while IFS= read xss ; do
   	sed -i 's/<script>alert("DarkLotusKDB")<\/script>//g' "$xss" &> /dev/null
    done < ./"${adn}"/Logs/Integrity-Check-Not-Implemented-On-WebView-Content-Local_Storage.txt

  echo -e "XSS Payload is removed.\n"
    break
  elif [[ $answer =~ ^[Nn]$ ]]; then
    echo "Okay, Not removing the XSS payload."
    break
  else
    echo -e "Invalid input. Please enter 'y' for yes or 'n' for no.\n"
  fi
	done

    break
  elif [[ $answer =~ ^[Nn]$ ]]; then
	echo -e "\e[33m\n[#] Not Vulnerable\e[0m" 
    break
  else
    echo -e "Invalid input. Please enter 'y' for yes or 'n' for no.\n"
  fi
done

else
	echo "Not Found in Local Storage"
fi


}




fbase(){

echo -e "\e[32m\n\n[+] Misconfigured Firebase\e[0m"

Io=$(find "$nf"/ -type f -exec grep -iao "......firebaseio.." {} + | sort -u)

echo "$Io" | tee ./"${adn}"/Logs/Misconfigured-Firebase.txt

  if echo "$Io" | grep -i "firebase" &> /dev/null ; then
	echo -e  "\e[33m\n[*] Info: Misconfigured Firebase\e[0m"
else
	echo -e "\e[33m\n[#] Not Found (Confirm manually)\e[0m"
fi
}



Dlink(){

echo -e "\e[32m\n\n[+] Scanning DeepLinks\e[0m"

Io=$(find "$nf"/ -iname "*.plist" -type f -exec grep -ia -A2 '<key>CFBundleURLSchemes</key>' {} +)

echo "$Io" | tee ./"${adn}"/Logs/Scanning-DeepLink.txt

  if echo "$Io" | grep -i "string" &> /dev/null ; then
  In=$(echo "$Io" | grep -o '<string>[^<]*' | awk -F'>' '{print $2}' | sed 's/$/:\/\//g')
  echo 
  find "$nf"/ -type f -exec grep -ioa "$In....." {} + | sort -u | sed 's/:/ ==>   /' | tee -a ./"${adn}"/Logs/Scanning-DeepLink.txt
	echo -e  "\e[33m\n[*] Info: Scanning DeepLinks\e[0m"
#else
#	echo -e "\e[33m\n[#] Not Vulnerable\e[0m"
fi
}


Ynd(){
  #echo -e "\e[33m\n\n[*] Confirm the following manual testcases:\e[0m"
  echo -e "\e[33m\n[#] Please manually confirm the following testcases to include them in the STR file.\e[0m"
  echo -e "\e[31m[*] y : For vulnerable\e[0m"
  echo -e "\e[32m[*] n : For Not vulnerable\e[0m"
}

Jdiss(){
echo -e "\e[32m\n\n[+] No Jailbreak Detection\e[0m"
#echo -e "\e[31m\n[\] Please install the app in which Jailbreak Detection is Enabled.\e[0m\n"

#read -p "Done with the above mentioned step?, Press any key to continue..."
echo ""
#echo -e "\e[33m\n[*] Please provide few words from the target app name: \e[0m"
#read anm
echo -e "\n\nKamal:~ root#\e[93m ps aux | grep -i '"$nb"'\e[0m"
ps aux | grep -i "$anm"
echo -e "\n\nKamal:~ root#\e[93m id\e[0m"
id

echo -e "\n"

while true; do
echo -e "\e[33m"
  read -rp "Is it vulnerable to No Jailbreak Detection? [y/n]: " -e answer
  echo -e "\e[0m"

  if [[ $answer =~ ^[Yy]$ ]]; then
   
   	echo -e "\e[31m\n[-] Vulnerable: No Jailbreak Detection\e[0m"
    break
  elif [[ $answer =~ ^[Nn]$ ]]; then
    echo -e "\e[33m\n[#] Not Vulnerable\e[0m"
    MJdiss 
    break
  else
    echo -e "Invalid input. Please enter 'y' for yes or 'n' for no.\n"
  fi
done
}



MJdiss(){
echo -e "\e[32m\n\n[+] Jailbreak Detection Bypass\e[0m"

#echo -e "\e[31m\n[\] Please install the app in which Jailbreak Detection is Enabled.\e[0m\n"
echo -e "\e[31m\n[\] Follow the below mentioned functional path in your device:\nSettings -> Liberty Lite -> Enable Liberty -> Block Jailbreak Detection, enable the Liberty for target app.\e[0m\n"

echo -e "\n\n[*] Use the \e[33miOS Reloader\e[0m tool (https://github.com/darklotuskdb/ios-reloader) to install multiple applications that can be used for bypassing Jailbreak detection and installing all other necessary applications on your iOS device.\n"


echo -e '[*] It will install the following Jailbreak Detection Byass Tools: 
A-Bypass
AJB
FlyJB X
Hestia
HideJB
iHide
JailProtect
KernBypass
Liberty Lite
Shadow
Sniperbypassjb
Vnodebypass
\n'

#read -p "Done with the above mentioned steps?, Press any key to continue..."
#echo ""
#echo -e "\e[33m\n[*] Please provide few words from the target app name: \e[0m"
#read anm

echo -e "\n\nKamal:~ root#\e[93m ps aux | grep -i '"$nb"'\e[0m"
ps aux | grep -i "$anm"
echo -e "\n\nKamal:~ root#\e[93m id\e[0m"
id

echo -e "\n"
while true; do
 echo -e "\e[33m"
  read -rp "Are you able to bypass the jailbreak detection? [y/n]: " -e answer
  echo -e "\e[0m"

  if [[ $answer =~ ^[Yy]$ ]]; then
   	echo -e "\e[31m\n[-] Vulnerable: Jailbreak Detection Bypass\e[0m"
    break
  elif [[ $answer =~ ^[Nn]$ ]]; then
    echo -e "\e[33m\n[#] Not Vulnerable\e[0m" 
    break
  else
    echo -e "Invalid input. Please enter 'y' for yes or 'n' for no.\n"
  fi
done

}


Mnnl(){


while true; do
  read -rp "$(echo -e "\e[32m\n\n[+] Unmasked Sensitive Data [y/n]: \e[0m")" -e answer
  echo

  if [[ $answer =~ ^[Yy]$ ]]; then
   	echo -e "\e[31m\n[-] Vulnerable: Unmasked Sensitive Data\e[0m"
    break
  elif [[ $answer =~ ^[Nn]$ ]]; then
    echo -e "\e[33m\n[#] Not Vulnerable\e[0m"
    break
  else
    echo -e "Invalid input. Please enter 'y' for yes or 'n' for no.\n"
  fi
done


while true; do
  read -rp "$(echo -e "\e[32m\n\n[+] Application Not Disabled Sensitive Data From Being Copied [y/n]: \e[0m")" -e answer
  echo

  if [[ $answer =~ ^[Yy]$ ]]; then
   	echo -e "\e[31m\n[-] Vulnerable: Application-Not-Disabled-Sensitive-Data-From-Being-Copied\e[0m"
    break
  elif [[ $answer =~ ^[Nn]$ ]]; then
    echo -e "\e[33m\n[#] Not Vulnerable\e[0m"
    break
  else
    echo -e "Invalid input. Please enter 'y' for yes or 'n' for no.\n"
  fi
done


while true; do
  read -rp "$(echo -e "\e[32m\n\n[+] Screenshot Disclosing Sensitive Information [y/n]: \e[0m")" -e answer
  echo

  if [[ $answer =~ ^[Yy]$ ]]; then
	echo -e "\e[31m\n[-] Vulnerable: Screenshot Disclosing Sensitive Information\e[0m"
    break
  elif [[ $answer =~ ^[Nn]$ ]]; then
    echo -e "\e[33m\n[#] Not Vulnerable\e[0m"
    break
  else
    echo -e "Invalid input. Please enter 'y' for yes or 'n' for no.\n"
  fi
done


while true; do
  read -rp "$(echo -e "\e[32m\n\n[+] Application Allows Custom Keyboards On Sensitive Fields [y/n]: \e[0m")" -e answer
  echo

  if [[ $answer =~ ^[Yy]$ ]]; then
	echo -e "\e[31m\n[-] Vulnerable: Application Allows Custom Keyboards On Sensitive Fields\e[0m"
    break
  elif [[ $answer =~ ^[Nn]$ ]]; then
    echo -e "\e[33m\n[#] Not Vulnerable\e[0m"
    break
  else
    echo -e "Invalid input. Please enter 'y' for yes or 'n' for no.\n"
  fi
done


while true; do
  read -rp "$(echo -e "\e[32m\n\n[+] Missing Security Checks on the Enrollment of Additional Biometrics [y/n]: \e[0m")" -e answer
  echo

  if [[ $answer =~ ^[Yy]$ ]]; then
	echo -e "\e[31m\n[-] Vulnerable: Missing Security Checks on the Enrollment of Additional Biometrics\e[0m"
    break
  elif [[ $answer =~ ^[Nn]$ ]]; then
    echo -e "\e[33m\n[#] Not Vulnerable\e[0m"
    break
  else
    echo -e "Invalid input. Please enter 'y' for yes or 'n' for no.\n"
  fi
done

while true; do
  read -rp "$(echo -e "\e[32m\n\n[+] Biometric Authentication Bypass [y/n]: \e[0m")" -e answer
  echo

  if [[ $answer =~ ^[Yy]$ ]]; then
	echo -e "\e[31m\n[-] Vulnerable: Biometric Authentication Bypass\e[0m"
    break
  elif [[ $answer =~ ^[Nn]$ ]]; then
    echo -e "\e[33m\n[#] Not Vulnerable\e[0m"
    break
  else
    echo -e "Invalid input. Please enter 'y' for yes or 'n' for no.\n"
  fi
done


while true; do
  read -rp "$(echo -e "\e[32m\n\n[+] Certificate Pinning Not Implemented [y/n]: \e[0m")" -e answer
  echo

  if [[ $answer =~ ^[Yy]$ ]]; then
	echo -e "\e[31m\n[-] Vulnerable: Certificate Pinning Not Implemented\e[0m"
    break
  elif [[ $answer =~ ^[Nn]$ ]]; then
    echo -e "\e[33m\n[#] Not Vulnerable\e[0m"

      echo -e "\e[32m\n\n[+] Certificate Pinning Bypass\e[0m"

      #echo -e "\e[31m\n[\] Please install the app in which SSL Pinning is Enabled.\e[0m\n"
      echo -e "\e[31m\n[\] Follow the below mentioned functional path in your device:\nSettings -> SSL Kill Switch 2 -> Click on Disable Certificate Validation to enable it\e[0m\n"

      echo -e "\n\n[*] Use the \e[33miOS Reloader\e[0m tool (https://github.com/darklotuskdb/ios-reloader) to install multiple applications that can be used for bypassing Jailbreak detection and installing all other necessary applications on your iOS device.\n"

    echo ""
    #read -p "Done with the above mentioned steps?, Press any key to continue. And relaunch the application to verify the bypass."
    echo ""


    while true; do
      read -rp "$(echo -e "\e[33m\n\n[*] Certificate Pinning Bypassed? [y/n]: \e[0m")" -e answer
    echo

    if [[ $answer =~ ^[Yy]$ ]]; then
	    echo -e "\e[31m\n[-] Vulnerable: Certificate Pinning Bypass\e[0m"
      break
    elif [[ $answer =~ ^[Nn]$ ]]; then
      echo -e "\e[33m\n[#] Not Vulnerable\e[0m"
    break
    else
    echo -e "Invalid input. Please enter 'y' for yes or 'n' for no.\n"
    fi
  done


    break
  else
    echo -e "Invalid input. Please enter 'y' for yes or 'n' for no.\n"
  fi
done



#echo -e "\e[31m\n[#] Please execute the windows CMD script before proceeding\e[0m"



while true; do
  read -rp "$(echo -e "\e[33m\n\n[*] Lack of Authentication After Background Resume? [y/n]: \e[0m")" -e answer
  echo

  if [[ $answer =~ ^[Yy]$ ]]; then
	echo -e "\e[31m\n[-] Vulnerable: Lack of Authentication After Background Resume\e[0m"
    break
  elif [[ $answer =~ ^[Nn]$ ]]; then
    echo -e "\e[33m\n[#] Not Vulnerable\e[0m"
    break
  else
    echo -e "Invalid input. Please enter 'y' for yes or 'n' for no.\n"
  fi
done


}



Cpcheck(){
echo -e "\e[32m\n\n[+] Improper Application Cookie Policy\e[0m"

ca=$(find ./"${adn}"/input -type f -iname *Cookies.binarycookies* | head -1)

if echo "$ca" | grep -iao "Cookies.binarycookies" &> /dev/null ; then
  echo -e "\nKamal:~ root#\e[93m cat "$ca" | grep -ia 'NSHTTPCookieAcceptPolicy\|NSHTTPCookieAcceptPolicyAlways'\e[0m"

  if cat "$ca" | grep -ia 'NSHTTPCookieAcceptPolicy\|NSHTTPCookieAcceptPolicyAlways'; then
    echo -e "\e[31m\n[*] Additional Observation: Improper Application Cookie Policy\e[0m"  
    else
      echo -e "\e[33m\n[#] Not Vulnerable\e[0m" 
  fi
fi

ca=$(find "$xnmb"/ -type f -iname *Cookies.binarycookies* | head -1)

if echo "$ca" | grep -iao "Cookies.binarycookies" &> /dev/null ; then
  echo -e "\nKamal:~ root#\e[93m cat "$ca" | grep -ia 'NSHTTPCookieAcceptPolicy\|NSHTTPCookieAcceptPolicyAlways'\e[0m"
  if cat "$ca" | grep -ia 'NSHTTPCookieAcceptPolicy\|NSHTTPCookieAcceptPolicyAlways'; then
    echo -e "\e[31m\n[-] Vulnerable: Improper Application Cookie Policy\e[0m"  
    else
      echo -e "\e[33m\n[#] Not Vulnerable\e[0m" 
  fi
fi

}




#under development
Cmmd(){

echo -e "\e[31m\n[#] Please execute the windows CMD script before proceeding\e[0m"

echo -e "\e[32m\n\n[+] [y/n]: \e[0m"
read Op 

if [ "$Op" == "y" ] ; then 
	echo -e "\e[31m\n[-] Vulnerable: \e[0m"
else
	echo -e "\e[33m\n[#] Not Vulnerable\e[0m"
fi


}

Str_gen(){

  

cat ./"${adn}"/Logs/1-${anm}-Terminal.log | grep -a -A40 'Summary Of Findings' | sed -r "s/\x1B\[([0-9]{1,3}(;[0-9]{1,2};?)?)?[mGK]//g" | grep -a 'Vulnerable:\|Possible:\|Observation:' | sed 's/\[-] Vulnerable://g' | sed 's/\[\*] Possible://g' | sed 's/\[\*] Additional Observation://g' | sed 's/ //' | awk -F', ' '!a[$1 FS $2]++' > ./"${adn}"/Logs/2-sof.log

#echo -e "Application Binary File Name (ps aux | grep -i "$nb"): \t<----app-bin-name---->\nApplication Name (frida-ps -Ua): \t\t\t<----app-name---->\nApplication Identifier Name (frida-ps -Ua): \t\t<----app-pkg-name---->\nJbDisabled-SSLDisabled: \t\t\t\t<----fileJD-SD.ipa---->\nJbDisabled-SSLEnabled: \t\t\t\t\t<----fileJD-SE.ipa---->\nJbEnabled-SSLEnabled: \t\t\t\t\t<----fileJDE-SE.ipa---->\n==================================================================================\n\n" > ./"${adn}"/Logs/3-Report.txt

echo -e "Application Binary File Name (ps aux | grep -i "$anm"): \t"$nb"\nApplication Name (frida-ps -Ua): \t\t\t"$pan"\nApplication Identifier Name (frida-ps -Ua): \t\t"$xnma"\nIPA-File: \t\t\t\t<----IPA-File---->.ipa\nSSL-Enabled-IPA: \t\t\t\t\t<----SSL---->.ipa\nJB-Enabled-IPA: \t\t\t\t\t<----JB---->.ipa\n==================================================================================\n\n" > ./"${adn}"/Logs/3-Report.txt


file=./mainSTRs.txt
i=1

while IFS= read vn;
do 
echo "$i. $(awk "/${vn}/{p=1} p && /=============/ {exit} p" "$file")"
((i=i+1))
echo -e "\n"
done < ./"${adn}"/Logs/2-sof.log >> ./"${adn}"/Logs/3-Report.txt

echo

sed -i "s/<--mos-->/$mos.0/g" ./"${adn}"/Logs/3-Report.txt
sed -i "s/<----app-bin-name---->/$nb/g" ./"${adn}"/Logs/3-Report.txt
sed -i "s/<----app-name---->/$pan/g" ./"${adn}"/Logs/3-Report.txt
sed -i "s/<----app-pkg-name---->/$xnma/g" ./"${adn}"/Logs/3-Report.txt
Tnf=$(echo $nf | sed 's/\//\\\//g')
sed -i "s/<--bfp-->/$Tnf/g" ./"${adn}"/Logs/3-Report.txt
Txnmb=$(echo $xnmb | sed 's/\//\\\//g')
sed -i "s/<--dfp-->/$Txnmb/g" ./"${adn}"/Logs/3-Report.txt
Txsp=$(echo $xsp | sed 's/\//\\\//g')
sed -i "s/<--xssp-->/$Txsp/g" ./"${adn}"/Logs/3-Report.txt
Txsl=$(echo $xsl | sed 's/\//\\\//g')
sed -i "s/<--xssl-->/$Txsl/g" ./"${adn}"/Logs/3-Report.txt

echo -e "\e[33m[/] Creating a Logs-${anm}.zip file containing all the logs generated during the current run of the tool.\e[0m"
zip -r ./"${adn}"/Logs-${anm}.zip ./"${adn}"/Logs/ &> /dev/null
}


#JD-SD

Cytool
Ynd
Jdiss
Mnnl
Wup
Antid
HcodedS
Sndata
Cpcheck
Sinfo
Aslr
Arc
Stcan
Cdova
Ipp 
Uhtp
#Nlv need to improve
Rann
Ikey
#Hcode need to improve
Trns
Mos
Cao
#all new updates
fbase
Dlink
Bobf

#relaunch
Wxss

#JE-S*

#JE-SE

#others
#Cmmd



#summary
echo -e "\e[32m\n\n[+] Summary Of Findings:\e[0m\n"  
cat "./"${adn}"/Logs/1-${anm}-Terminal.log" | grep -a 'Vulnerable:' | sort -u
cat "./"${adn}"/Logs/1-${anm}-Terminal.log" | grep -a 'Possible:'
cat "./"${adn}"/Logs/1-${anm}-Terminal.log" | grep -a 'Additional Observation:'
cat "./"${adn}"/Logs/1-${anm}-Terminal.log" | grep -a 'Info:'

Str_gen
}



while getopts 'a:d:' flag; do
	case "$flag" in
	  a) anm="${OPTARG}" ;;
	  d) adn="${OPTARG}" ;;
	  *) print_usage
		exit 1 ;;
	esac
done

if [[ $# -gt 2 ]] ; then
	mkdir -p ./"${adn}"/Logs

	Banner | tee ./"${adn}"/Logs/1-${anm}-Terminal.log
	MainIOS | tee -a ./"${adn}"/Logs/1-${anm}-Terminal.log
else
	Banner
	print_usage
fi

echo
echo -e "Is it helpful and time-saver? \nThen don't forget to provide your valuable feedback for further improvement of this tool on our Slack channel #ios-buster-tool."
echo
echo -e "Thank You,\nKamaldeep Bhati (@DarkLotusKDB)"
echo
echo -e "\e[31mHappy Hacking :-)\e[0m"
echo

