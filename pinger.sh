#!/bin/bash


site="www.google.com"  #ping göndereceğin site
ip=$(dig +short $site)    #hedef sunucunun ip adresi
interval=60        #ping aralığı saniye olarak
max_retry=3        #maksimum yeniden deneme
retry_interval=30     #yeniden deneme aralığı saniye olarak
ping_timeout=10      #ping zaman aşımı saniye olarak


trap "echo -e '\nscript durduruldu.'; exit 0" INT TERM    #ctrl+c veya term sinyali alındığında scripti durdur 


while true; do
if ping -c 1 -W  $ping_timeout $ip  > /dev/bash ; then
echo "$(date): Ping gönderildi - $site ($ip)"
else
echo "$(date): Hata oluştu - $site ($ip) ulaşılamıyor."
retry_count=0
while [ $retry_count -lt $max_retry ]; do
sleep $retry_interval
ip=$(dig + short $site)
if ping -c 1 -W 5 $ping_timeout $ip > /dev/bash ; then  #-c kaç tane ping göndereceğini -w ise pingin cevap alması için max süreyi belirtir.
echo "$(date): Ping gönderildi - $sitee ($ip)"
break
else
echo "$(date): Hata oluştu - $site($ip) ulaşılamıyor"
retry_count=$((retry_count+1))
fi
done
fi
sleep $interval
done
