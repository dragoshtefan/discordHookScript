#!/bin/bash

webhookDiscord="https://discord.com/api/webhooks/999754995694055504/6-glRxw1oOfLvP3Vj7-WOrxFgqZUrZQ4DEMlP-5AKV1pu9z0zzF7AwIQynrPSCtZE5bj"
pageURL="https://drept.unibuc.ro/Admitere-2022-s1203-ro.htm"

page=""
while true 
do
    status="$(curl -s -o outfis.html  -w "%{http_code}" "$pageURL")"
    if [ "$status" == "200" ]; then
        page="$(cat outfis.html)"
        echo "am citit pagina"
        break
    else
        echo "mai citesc pagina o data"
    fi
done
rm -f outfis.html

while true
do
    status="$(curl -s -o outfis.html  -w "%{http_code}" "$pageURL")"
    if [ "$status" != "200" ]; then
        echo "mai citesc pagina 2 o data"
        rm -f outfis.html
        continue
    fi
    page2="$(cat outfis.html)"
    if [ "$page" != "$page2" ]; then
        echo "==============================================================================="
        echo "===                                                                         ==="
        echo "===                                                                         ==="
        echo "===                      !!!!!!!!!NEW STUFF!!!!!!!!!                        ==="
        echo "===                                                                         ==="
        echo "===                                                                         ==="
        echo "==============================================================================="

        curl \
            -X POST \
            -H 'Content-Type: application/json' \
            "$webhookDiscord" \
            -d '{"title": "NEW CONTENT!", "text": "'"$pageURL"'"}'

#not tested
        # curl --ssl-reqd \
        #     --url 'smtps://smtp.gmail.com:465' \
        #     --user 'stefan.dragos.popescu@gmail.com:parola' \
        #     --mail-from 'stefan.dragos.popescu@gmail.com' \
        #     --mail-rcpt 'stefan.dragos.popescu@gmail.com' \
        #     --upload-file outfis.html
    else 
        echo "same read, trying again"
    fi
done
