#!/bin/bash

###
#
# NOTES: the httpclient-contrib package is not in mave... so this won't work. 

# http://sourceforge.net/projects/mturksdk-java/

# http://sourceforge.net/p/mturksdk-java/code/HEAD/tree/trunk/lib/third-party/

VERSION=1.6.2

mvn org.apache.maven.plugins:maven-install-plugin:2.3.1:install-file \
    -Dfile=lib/ext/commons-httpclient-contrib-3.1.jar \
    -DgroupId=commons-httpclient \
    -DartifactId=commons-httpclient-contrib \
    -Dversion=3.1 \
    -Dpackaging=jar

rm lib/third-party/*

# use the pom to fetch our libs.
mvn dependency:copy-dependencies -DoutputDirectory=lib/third-party/

ant jar

# now place the generated .jars into maven so that I can depend on them in 
# artemis-mturk

mvn org.apache.maven.plugins:maven-install-plugin:2.3.1:install-file \
    -Dfile=build/lib/aws-mturk-dataschema-$VERSION.jar \
    -DgroupId=aws-mturk-dataschema \
    -DartifactId=aws-mturk-dataschema \
    -Dversion=$VERSION \
    -Dpackaging=jar

mvn org.apache.maven.plugins:maven-install-plugin:2.3.1:install-file \
    -Dfile=build/lib/aws-mturk-wsdl-$VERSION.jar \
    -DgroupId=aws-mturk-wsdl \
    -DartifactId=aws-mturk-wsdl \
    -Dversion=$VERSION \
    -Dpackaging=jar

mvn org.apache.maven.plugins:maven-install-plugin:2.3.1:install-file \
    -Dfile=build/lib/java-aws-mturk-$VERSION.jar \
    -DgroupId=java-aws-mturk \
    -DartifactId=java-aws-mturk \
    -Dversion=$VERSION \
    -Dpackaging=jar

