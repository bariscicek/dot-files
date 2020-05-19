#/bin/sh
tmux attach
if [ "$?" -eq "1" ]; then
	tmux
fi

