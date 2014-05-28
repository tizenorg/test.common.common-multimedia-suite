#!/bin/bash
#
#  Copyright (C) 2011, Intel Corporation
#
#  This program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU Lesser General Public License as published
#  by the Free Software Foundation; either version 2 of the License,
#  or (at your option) any later version.
#
#  This program is distributed in the hope that it will be useful, but
#  WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
#  General Public License for more details.
#
#  You should have received a copy of the GNU Lesser General Public License
#  along with this program; if not, write to the Free Software
#  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307
#  USA.
#
#  Authors:
#      Zhang Zhiqiang  <zhiqiang.zhang@intel.com>
#
#  Modificator:
#      Li Cathy <cathy.li@intel.com>  Date: 2012-02-24
#
#  DESCR:
#      Test GStreamer pipeline using playbin2 with uri only.
#


# check parameter sanity
if [ $# -lt 1 ]; then
    echo "Usage: $0 <URI> [TIMEOUT]"
    echo "  URI is to set playbin uri with protocol FILEE/HTTP/RTSP"
    echo "  TIMEOUT is the time in seconds you want playbin2 to play the media"
    echo "You need to set URI of the media file to play"
    exit 1
fi


. $(cd `dirname $0`;pwd)/env.sh


# play the media with GStreamer su - app -c "XDG_RUNTIME_DIR=/run/user/5000 && gst-auto-launch and playbin2 for 10 seconds
# su - app -c "XDG_RUNTIME_DIR=/run/user/5000 && gst-auto-launch playbin2 uri=$1 0:play 10:eos

# play the media with GStreamer gst-launch and playbin2
if [ $UID = 0 ];then
	su - app -c "XDG_RUNTIME_DIR=/run/user/5000 && gst-launch-1.0 playbin uri="$1" &> $TEST_RESULT &"
else
	gst-launch-1.0 playbin uri=$1 &> $TEST_RESULT &
fi

# check error message after TIMEOUT or 3 seconds
if [ -n "$2" ]; then
   sleep $2
else
  sleep 3
fi

ERR=$(cat $TEST_RESULT | grep "ERROR")

if [ -n "$ERR" ]; then
    cat $TEST_RESULT
    RET=1
fi

# clean up
. $(cd `dirname $0`;pwd)/cleanup.sh
exit $RET

