#/bin/bash
# generate docker container name
target_container_name=`ls *.jar | head -n 1 | awk -F '.jar' '{print tolower($1)}'`

echo "target container name is $target_container_name"

# delete existing container
flag=0

all_container_name=`docker ps -a  | awk -F ' ' '{print $NF}' | sed -n '2,$p'`

for container in $all_container_name;
do
  if [ $target_container_name = $container ]; then
	  flag=1
  fi
done

echo "container if exists: $flag"

if [ $flag -eq 1 ]; then
   
   docker rm -f $target_container_name
   if [ $? -ne 0 ]; then
	   echo "$target_container_name delete failed!"
	   exit 0
   else
	   echo "$target_container_name delete successful"
   fi
else
  echo "container: $target_container_name is not existed!"
fi

# delete existing image
all_image_name=`docker images | sed -n '2,$p' | awk -F ' ' '{print $1}'`
flag=0

for image in $all_image_name;
do
  if [ $target_container_name = $image ]; then
	  flag=1
  fi
done

echo "image if exists: $flag"

if [ $flag -eq 1 ]; then

   # delete existing container
   docker rmi -f $target_container_name
   
   if [ $? -ne 0 ]; then
	   echo "$target_container_name delete failed!"
	   exit 0
   else
	   echo "$target_container_name delete successful"
   fi

else

  echo "image: $target_container_name is not existed!"

fi

# build docker image
echo "begin to build docker image"
docker build -f ./Dockerfile --tag $target_container_name --rm --pull .

if [ $? -ne 0 ]; then
	echo "image: $target_container_name image build failed"
	exit 0
fi

echo "start run docker containner......."

docker run -i -d -P --name=$target_container_name $target_container_name /bin/bash /root/start_web.sh

if [ $? -ne 0 ]; then
	echo "$target_container_name run failed"
	exit 0
fi

# get service access port
port=`docker port jenkins-1.0-snapshot | awk -F ':' '{print $2}'`

echo "service access port is $port, enjoy your service ......"
