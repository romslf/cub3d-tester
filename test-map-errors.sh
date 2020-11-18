#!/bin/bash
execPath="Cub3D"
makePath="."
mapsPath='cub3d-tester/maps/errors/'

termwidth="$(tput cols)"
green='\e[1;32m'
yellow='\e[93m'
blueBg='\e[46m'
blue='\e[34m'
red='\e[31m'
end='\e[0m'
end='\e[0m'
passed=0
failed=0

head () {
  padding="$(printf '%0.1s' \#{1..500})"
  printf "\n${yellow}%*.*s %s %*.*s${end}\n" 0 "$(((termwidth-5-${#1})/2))" "$padding" "  $1  " 0 "$(((termwidth-6-${#1})/2))" "$padding"
}

log () {
  padding="$(printf '%0.1s' ={1..500})"
  printf "${blue}%*.*s %s %*.*s${end}\n" 0 "$(((termwidth-5-${#1})/2))" "$padding" "  $1  " 0 "$(((termwidth-6-${#1})/2))" "$padding"
}

pass () {
  let "passed+=1"
  padding="$(printf '%0.1s' -{1..500})"
  printf "${green}%*.*s %s %*.*s${end}\n\n" 0 "$(((termwidth-5-8)/2))" "$padding" " Passed " 0 "$(((termwidth-6-${#1})/2))" "$padding"
}

fail () {
  let "failed+=1"
  padding="$(printf '%0.1s' -{1..500})"
  printf "${red}%*.*s %s %*.*s${end}\n\n" 0 "$(((termwidth-5-8)/2))" "$padding" " Failed " 0 "$(((termwidth-6-${#1})/2))" "$padding"
}

launch () {
	log $1
	if ./${execPath} ${mapsPath}$1;
	then
		fail
	else
		pass
	fi
}

result () {
	if let "failed == 0";
	then
		printf "${green}YEAH ! All tests successfully passed ! Good job !${end}\n"
	else
		printf "${green}${passed}${end} tests passed, ${red}${failed}${end} tests failed.\n"
		printf "Don't worry, im sure you can fix it ! Keep it up !\n"
	fi
}

cd ..
head "Infos"
log "Make logs"
make -C ${makePath}
log "Date:"
date
log "Last commit:"
git --no-pager log --decorate=short --pretty=oneline -n1

head "Testing Resolution"
launch "map-res-0.cub"
launch "map-res-1.cub"
launch "map-res-2.cub"
launch "map-res-3.cub"
launch "map-res-4.cub"

head "Testing NO texture"
launch "map-no-0.cub"
launch "map-no-1.cub"
launch "map-no-2.cub"
launch "map-no-3.cub"
launch "map-no-4.cub"

head "Testing RGB"
launch "map-rgb-0.cub"
launch "map-rgb-1.cub"
launch "map-rgb-2.cub"
launch "map-rgb-3.cub"
launch "map-rgb-4.cub"

head "Testing spawns"
launch "map-spawn-0.cub"
launch "map-spawn-1.cub"
launch "map-spawn-2.cub"

head "DONE"
result