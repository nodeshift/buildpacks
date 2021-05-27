export UBI_VERSION=${1}
export NODE_JS_VERSION=${2}
export POSTFIX=${3}
mkdir -p temp
cat ./builder.toml.template | sed -e 's/UBI_VERSION/'${UBI_VERSION}'/g' \
                            | sed -e 's/NODE_JS_VERSION/'${NODE_JS_VERSION}'/g' \
                            | sed -e 's/POSTFIX/'${POSTFIX}'/g' \
                            >./temp/nodejs-${NODE_JS_VERSION}_ubi-${UBI_VERSION}_builder.toml
pack create-builder nodejs-${NODE_JS_VERSION}_ubi-${UBI_VERSION}_builder --pull-policy if-not-present --config ./temp/nodejs-${NODE_JS_VERSION}_ubi-${UBI_VERSION}_builder.toml
