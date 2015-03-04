#!/bin/bash

# Usage: package.sh VERSION PATH_TO_JAR

VERSION=\$1
PATH_TO_JAR=\$2

DIR=\$(cd "\$( dirname "\${BASH_SOURCE[0]}" )" && pwd)

fpm -s dir \
    -a all \
    --rpm-os linux \
    -t rpm \
    -n "$name;format="norm"$" \
    --description "Package for Discussion API" \
    -v \$VERSION \
    -d aws-cli \
    --before-install \$DIR/before-install.sh \
    --after-install \$DIR/after-install.sh \
    \$PATH_TO_JAR=/opt/gu/discussion/$name;format="norm"$.jar
