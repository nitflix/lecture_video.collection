#!/usr/bin/env jq

. as $input
| $input | keys as $keys
| $keys[]
| . as $key
| $input[$key][][]
| . as $title
| @sh "make download -e project_name=\"\($project_name)\" -e COURSE_HREF=\($key) -e VIDEO_TITLE=\"\($title)\""
