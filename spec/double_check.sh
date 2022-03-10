# echo https://ocw.mit.edu/$item/video-lectures
# response=$( curl -LsI https://ocw.mit.edu/$item/video-lectures | grep 404 | head -n 1)
# echo $response | jq -R

interface=cat
url=$1
$interface $url | jq -r '.[] | select(.completeVideo == true)' | jq -rs '.[].href' | wc -l
