# https://github.com/getcarina/dvm
# . ~/.dvm/dvm.sh

dmachine() {
	[ -z "$1" ] && MACHINE="--unset" || MACHINE="$1"
	eval $(docker-machine env $MACHINE)
}

dssh() {
	docker-machine ssh $1
}

dswarm() {
	eval $(docker-machine env --swarm $1)
}

dstate() {
	docker-machine status $1
}

ddev() {
	DEVMACHINE=mgrdev1
	if dstate mgrdev1 | grep Stopped ; then
		docker-machine start mgrdev1 && docker-machine regenerate-certs -f mgrdev1
	fi
	if dstate mgrdev1 | grep Running; then
		dmachine mgrdev1
	else
		echo Error starting mgrdev1
	fi
}
