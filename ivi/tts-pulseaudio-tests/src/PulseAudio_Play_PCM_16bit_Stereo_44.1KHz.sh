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
#     Play a stereo raw PCM audio file by paplay with default settings
#
# TIMEOUT: 20


. $(cd `dirname $0`;pwd)/env.sh

#DATA="$DATA_PATH/PCM_16bit_Stereo_44.1KHz_1411Kbps_10s(1.6Mb).WAV"
#if ! [ -f $DATA ]; then
#    echo "Error: not exist the file $DATA"
#    exit 1
#fi

if [ $UID = 0 ];then
        su - app -c "XDG_RUNTIME_DIR=/run/user/5000  paplay ${MF_TEST_44K_1}"
else
        paplay ${MF_TEST_44K_1}
fi

if [ $? -ne 0 ]; then
    echo "Failed to play the sample"
    exit 1
fi

