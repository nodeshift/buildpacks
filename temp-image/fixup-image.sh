docker build --build-arg ubi_version=${1} \
             --build-arg node_version=${2} \
             --label io.buildpacks.stack.id=com.redhat.stacks.ubi${1}-nodejs-${2} \
             . -t "registry.access.redhat.com/ubi${1}/nodejs-${2}-fixed" 

