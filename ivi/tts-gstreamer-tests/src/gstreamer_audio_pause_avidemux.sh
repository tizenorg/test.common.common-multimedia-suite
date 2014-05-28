#!/bin/bash
#
# Copyright (C) 2008-2011 Intel Corporation.
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
#     Check gstreamer avidemux pause status
#
# TIMEOUT: 200
. $(cd `dirname $0`;pwd)/env.sh

su - app -c "XDG_RUNTIME_DIR=/run/user/5000 && gst-auto-launch filesrc location=${GT_AUDIO_PCM_16} num-buffers=50 ! avidemux name=demux  demux.audio_0 ! decodebin ! audioconvert ! audioresample ! autoaudiosink 0:play 0.5:pause  1:play &> $TEST_RESULT &"

sleep 10

a=$(cat $TEST_RESULT | grep "PAUSED")


if [ "$a" = "Passing to PAUSED" ]; then
    echo "gstreamer avidemux pause pass"
else
    echo "gstreamer avidemux pause fail"
    cat $TEST_RESULT
    RET=1
fi

. $(cd `dirname $0`;pwd)/cleanup.sh
exit $RET


