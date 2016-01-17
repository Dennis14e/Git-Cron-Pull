#!/bin/bash

declare -A repositories
# repositories["<repository_name"]="<repository_path> <repository_branch>"
# repositories["website"]="/var/www/html master" 


if [ "$#" -ne 1 ]
then
	echo "Usage: $0 <repository>"
	exit 1
fi

if [ ${repositories["$1"]+isset} ]
then
	repository=(${repositories["$1"]})
	git --git-dir="${repository[0]}/.git" --work-tree="${repository[0]}" pull origin "${repository[1]}"

	# If repository-path begins with "/var/www/"
	if [[ "$repository[0]" =~ ^/var/www/* ]]
	then
		chown -R www-data:www-data $repository
	fi

	exit 0
fi

>&2 echo "Repository does not exists"
exit 1
