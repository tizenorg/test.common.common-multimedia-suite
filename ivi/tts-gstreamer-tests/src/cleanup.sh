#!/bin/bash
# Copyright (C) 2011, Intel Corporation.
# 
# This program is free software; you can redistribute it and/or modify it
# under the terms and conditions of the GNU General Public License,
# version 2, as published by the Free Software Foundation.
#
# This program is distributed in the hope it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
# FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
# for more details.  
#
# You should have received a copy of the GNU General Public License along with
# this program; if not, write to the Free Software Foundation, Inc., 59 Temple
# Place - Suite 330, Boston, MA 02111-1307 USA.
#
# Authors:
#     Zhang, Zhiqiang <zhiqiang.zhang@intel.com>
#
# DESCR:
#     Cleanup process like gst-launch or su - app -c "XDG_RUNTIME_DIR=/run/user/5000 && gst-auto-launch


# try to kill the process for 3 times
rm -rf /tmp/test_result
COUNT=0
while [ "$COUNT" -lt 3 ]; do
    PID=`ps -eaf | grep -E "gst-launch|gst-auto-launch" | grep -v "grep" | awk '{print $2}'`
    if [ -z "$PID" ]; then
        break;
    fi	

    echo "Kill $PID"
    kill $PID
    let "COUNT += 1"
done
