#!/bin/zsh
# logFile=$HOME/.cache/log/natapp.log
# cat $HOME/.config/.natapp.log | grep -oP 'server.natappfree.cc:\d+' | tail -1 >$HOME/.config/natapp.ip
# # echo check is commited

cd "${0:A:h}"
echo "${0:A:h}"
# SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
# cd $SCRIPT_DIR
# echo $SCRIPT_DIR


if [[ ! -z "$(git diff-index --name-only HEAD)" ]]; then
	git add -u
	git commit -m "$(date)"
	git remote update
	# if ! git diff --quiet origin/master; then
		# echo "the branch is different!"
    git push
	# fi
fi

for pid in $(pgrep -f  /opt/4T/natapp/bin/natapp); do
  if ! test $(mullvad split-tunnel list | grep $pid ) ; then
    mullvad split-tunnel add $pid ;
    echo add $pid to mullvad split-tunnel list ;
  else
    echo $pid exist in mullvad split-tunnel list;
  fi 
done
