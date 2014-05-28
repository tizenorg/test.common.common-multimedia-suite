#!/bin/bash
#
# Copyright (C) 2011 Intel Corporation.
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
#  Authors:
#      Zhang Zhiqiang  <zhiqiang.zhang@intel.com>
#
#  DESCR:
#      Check play status for audio u-LAW format.
#
#  TIMEOUT: 160


. $(cd `dirname $0`;pwd)/env.sh

su - app -c "XDG_RUNTIME_DIR=/run/user/5000 && gst-auto-launch filesrc location=$DATA_PATH/u-LAW_8bit_Stereo_44.1KHz_120sec\(10MB\)_AKM.wav num-buffers=50 ! wavparse ! mulawdec ! audioconvert ! autoaudiosink 0:play &> $TEST_RESULT &"

sleep 10

a=$(cat $TEST_RESULT | grep "PLAYING")


if [ "$a" = "Passing to PLAYING" ]; then
    echo "gstreamer play pass"
else
    echo "gstreamer play fail"
    cat $TEST_RESULT
    ERT=1
fi

. $(cd `dirname $0`;pwd)/cleanup.sh
exit $RET
