drive=$1
partials=$(ls $drive/*.part | split -l 1)
for item in $(ls x* | head -n 1); do
  _item=$(cat $item)
  make 'download' \
    -e batch=$item \
    -e project_name="'$_item'" \
    -e COURSE_HREF='incompletedownloads' \
    -e VIDEO_TITLE="'$_item'"
done
