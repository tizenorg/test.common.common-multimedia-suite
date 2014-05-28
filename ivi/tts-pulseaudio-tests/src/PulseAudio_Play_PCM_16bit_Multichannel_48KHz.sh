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
#     Play a multichannel raw PCM audio file by paplay with default settings
#
# TIMEOUT: 70


. $(cd `dirname $0`;pwd)/env.sh

#DATA="$DATA_PATH/PCM_16bit_5.1(Discrete)_48KHz_4608Kbps_38sec(21MB).wav"
#if ! [ -f $DATA ]; then
#    echo "Error: not exist the file $DATA"
#    exit 1
#fi

if [ $UID = 0 ];then
	echo $MF_TEST_48K
	su - app -c "XDG_RUNTIME_DIR=/run/user/5000  paplay ${MF_TEST_48K}"
else
	paplay $MF_TEST_48K
fi
if [ $? -ne 0 ]; then
    echo "Failed to play the sample"
    exit 1
fi

