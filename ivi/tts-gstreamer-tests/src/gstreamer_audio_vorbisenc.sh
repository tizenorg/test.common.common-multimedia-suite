#!/bin/bash
#DESCR : Check gstreamer vorbis codec encode status
#TIMEOUT : 200

#
# Copyright (C) 2008 Intel Corporation.
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU Lesser General Public
# License as published by the Free Software Foundation; either
# version 2.1 of the License, or (at your option) any later version.
#
# It is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# Lesser General Public License for more details.
#
# You should have received a copy of the GNU Lesser General Public
# License along with this software; if not, write to the Free
# Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
# 02111-1307 USA.
#                                                                                        
# Authors: 
#     Jessica JI <jessica.ji@intel.com>
#     Zhang Zhiqiang <zhiqiang.zhang@intel.com>
#
# DESCR:
#     Check vorbisenc work status
#
# TIMEOUT: 200 


. $(cd `dirname $0`;pwd)/env.sh
if [ -f /tmp/vorbisenc.ogg ];then rm -rf /tmp/vorbisenc.ogg;fi
if [ $UID = 0 ];then
	su - app -c "XDG_RUNTIME_DIR=/run/user/5000 && gst-launch-1.0 -v pulsesrc num-buffers=100 ! audioconvert ! vorbisenc ! oggmux ! filesink location=/tmp/vorbisenc.ogg &>$TEST_RESULT &"
else
	gst-launch-1.0 -v pulsesrc num-buffers=100 ! audioconvert ! vorbisenc ! oggmux ! filesink location=/tmp/vorbisenc.ogg &>$TEST_RESULT &
fi

#gst-launch-1.0 -v autoaudiosrc num-buffers=100 ! audioconvert ! vorbisenc ! oggmux ! filesink location=/tmp/vorbisenc.ogg &>$TEST_RESULT &

sleep 5

a=$(cat $TEST_RESULT | grep "EOS")


if [ "$a" = "Got EOS from element \"pipeline0\"." ]; then
    echo "gstreamer vorbisenc pass"
else
    echo "gstreamer vorbisenc fail"
    cat $TEST_RESULT
    RET=1
fi

. $(cd `dirname $0`;pwd)/cleanup.sh
exit $RET

