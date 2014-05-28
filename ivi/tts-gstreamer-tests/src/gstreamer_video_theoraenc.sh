#!/bin/bash
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
#     Check theoraenc work status
#
# TIMEOUT: 200


. $(cd `dirname $0`;pwd)/env.sh

su - app -c "XDG_RUNTIME_DIR=/run/user/5000 && gst-launch-1.0 v4l2src num-buffers=20 ! autovideoconvert ! theoraenc ! oggmux ! filesink location=/tmp/theoraenc.ogg &> $TEST_RESULT &"

sleep 30

a=$(cat $TEST_RESULT | grep "New clock")


if [ "$a" = "New clock: GstSystemClock" ]; then
    echo "gstreamer thenraenc pass"
else
    echo "gstreamer thenoraenc fail"
    cat $TEST_RESULT
    RET=1
fi

. $(cd `dirname $0`;pwd)/cleanup.sh
exit $RET


