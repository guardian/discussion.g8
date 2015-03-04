#!/bin/bash

# https://riffraff.gutools.co.uk/docs/magenta-lib/howto/make-deployable

# Provide trace (x), and exit on any error (e)
set -xe

BUILD_NUMBER=\${BUILD_NUMBER:-1} # provided by TeamCity
PATH_TO_DEPLOY_JSON=deploy.json

# ensure cleanup from previous build
rm -rf artifact && rm -f *.rpm && rm -f *.bak

# build and upload rpm
if sbt assembly
then
    PATH_TO_JAR=\$(find target/scala-*/ -name '*.jar')
else
    echo Failed to assemble jar.
    exit 1
fi

if ./package/package.sh \$BUILD_NUMBER \$PATH_TO_JAR
then
    PATH_TO_RPM=\$(find . -name '*.rpm')
    RPM_NAME=\$(basename "\$PATH_TO_RPM")
    sed -i.bak -e s/@@RPM_NAME/\$RPM_NAME/ \$PATH_TO_DEPLOY_JSON
else
    echo Failed to build rpm package.
    exit 1
fi

# publish artifact
mkdir -p artifact/packages/{$name;format="norm"$,$name;format="norm"$-rpm}
cp cloudformation/cfn.json artifact/packages/$name;format="norm"$/cfn.json
cp \$PATH_TO_RPM artifact/packages/$name;format="norm"$-rpm/
cp \$PATH_TO_DEPLOY_JSON artifact/
cd artifact
zip -rv artifacts.zip packages deploy.json

echo "##teamcity[publishArtifacts '\$(pwd)/artifacts.zip => .']"
