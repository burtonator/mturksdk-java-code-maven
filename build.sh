#!/bin/bash

###
#
# NOTES: the httpclient-contrib package is not in mave... so this won't work. 

# http://sourceforge.net/projects/mturksdk-java/

# http://sourceforge.net/p/mturksdk-java/code/HEAD/tree/trunk/lib/third-party/

VERSION=1.6.2
REPO=http://my.nexus.repo:8081

mvn deploy:deploy-file \
    -Dfile=lib/ext/commons-httpclient-contrib-3.1.jar \
    -DgroupId=commons-httpclient \
    -DartifactId=commons-httpclient-contrib \
    -Dversion=3.1 \
    -Dpackaging=jar \
    -Durl=$REPO/nexus/content/repositories/thirdparty \
    -DrepositoryId=nexus

rm lib/third-party/*

# use the pom to fetch our libs.
mvn dependency:copy-dependencies -DoutputDirectory=lib/third-party/

ant jar

# now deploy the generated .jars into nexus

mvn deploy:deploy-file \
    -Dfile=build/lib/aws-mturk-dataschema-$VERSION.jar \
    -DgroupId=com.amazonaws \
    -DartifactId=aws-mturk-dataschema \
    -Dversion=$VERSION \
    -Dpackaging=jar \
    -Durl=$REPO/nexus/content/repositories/thirdparty \
    -DrepositoryId=nexus

mvn deploy:deploy-file \
    -Dfile=build/lib/aws-mturk-wsdl-$VERSION.jar \
    -DgroupId=com.amazonaws \
    -DartifactId=aws-mturk-wsdl \
    -Dversion=$VERSION \
    -Dpackaging=jar \
    -Durl=$REPO/nexus/content/repositories/thirdparty \
    -DrepositoryId=nexus

mvn deploy:deploy-file \
    -Dfile=build/lib/java-aws-mturk-$VERSION.jar \
    -DgroupId=com.amazonaws \
    -DartifactId=java-aws-mturk \
    -Dversion=$VERSION \
    -Dpackaging=jar \
    -DpomFile=pom.xml \
    -Durl=$REPO/nexus/content/repositories/thirdparty \
    -DrepositoryId=nexus
