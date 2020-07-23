#/bin/bash
cd /root
echo "current dir:" `pwd`
jar_name=`ls *.jar | head -n 1`
java -jar $jar_name --server.port=9999
