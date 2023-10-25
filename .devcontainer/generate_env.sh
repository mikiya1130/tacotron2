cat <<EOF > $(cd $(dirname $0);pwd)/.env
USERNAME=$(id -un)
USER_UID=$(id -u)
USER_GID=$(id -g)
EOF
