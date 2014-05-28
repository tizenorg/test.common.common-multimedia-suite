#!/bin/bash
# Copyright (C) 2011 Intel Corporation
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
#
# Authors:
#     Zhang, Zhiqiang <zhiqiang.zhang@intel.com>
#
# DESCR:
#     Record a raw PCM audio file by parec with default settings, and
#     play the recorded audio file by paplay
#
# TIMEOUT: 120


DATA=/tmp/parec.wav

# Record a raw PCM audio/noise
if [ $UID = 0 ];then
	su - app -c "XDG_RUNTIME_DIR=/run/user/5000  parec --record /tmp/parec.wav &"
else
	parec --record $DATA &
fi

# Stop recording after 10 seconds
sleep 10

COUNT=0
while [ "$COUNT" -lt 3 ] # try 3 times
do
    PID=`ps -eaf | grep parec | grep -v "grep" | awk '{print $2}'`
    if [ -z "$PID" ]; then
        break;
    fi	
    kill $PID 
    let "COUNT += 1" # increase COUNT
done

# Check the recorded audio file
if ! [ -s $DATA ]; then
    echo "Error: failed to record voice by parec with default settings"
    exit 1
fi

# Play the recorded audio file
if [ $UID = 0 ];then
	su - app -c 'XDG_RUNTIME_DIR=/run/user/5000  paplay --raw /tmp/parec.wav'
else
	paplay --raw $DATA
fi
if [ $? -ne 0 ]; then
    echo "Error: failed to play the recorded audio file"
    exit 1
fi

rm -f $DATA
exit 0
