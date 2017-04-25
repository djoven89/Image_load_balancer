#!/bin/bash
set -eo pipefail
shopt -s nullglob

for i in {1..5}
 do
  if [ $WEB$i ] 
   then
      echo $WEB$i >> /archivo.txt
#     x=`env | grep WEB$i | cut -d "=" -f2`
#     echo $x
#     grep -o 172.20.0.2$i /etc/nginx/sites-available/default | xargs -I '{}' sed -i "s/{}/$x/" /etc/nginx/sites-available/default
   else
      echo "No existe." >> /archivo.txt
  fi  
done

exec "$@"
