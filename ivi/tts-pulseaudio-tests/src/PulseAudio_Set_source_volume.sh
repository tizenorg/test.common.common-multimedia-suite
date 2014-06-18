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
#     Set default source vloume value
# TIMEOUT: 30


. $(cd `dirname $0`;pwd)/env.sh

# Find the source name and volume value
if [ $UID = 0 ];then
	SOURCE_NAME=`su - app -c "XDG_RUNTIME_DIR=/run/user/5000 pa_query_control -qo" | head -n 1 | awk -F, '{print $2}' | cut -d "=" -f2`
	VOLUME=`su - app -c "XDG_RUNTIME_DIR=/run/user/5000 pa_query_control -qo" | head -n 1 | awk -F, '{print $4}' | cut -d "=" -f2 | awk '{print $2}'`
else
	SOURCE_NAME=`pa_query_control -qo | head -n 1 | awk -F, '{print $2}' | cut -d "=" -f2`
	VOLUME=`pa_query_control -qo | head -n 1 | awk -F, '{print $4}' | cut -d "=" -f2 | awk '{print $2}'`
fi

if [ $? -ne 0 ]; then
    echo "Error: failed to find source volume value"
    echo "Please check that if pulseaudio is running or if proper permission is granted"
    exit 1
fi

# Set source volume value for the 1st channel
if [ $UID = 0 ];then
	su - app -c "XDG_RUNTIME_DIR=/run/user/5000 pa_query_control -cv source $SOURCE_NAME 1 65536"
	su - app -c "XDG_RUNTIME_DIR=/run/user/5000 pa_query_control -cv source $SOURCE_NAME 1 40000"
	su - app -c "XDG_RUNTIME_DIR=/run/user/5000 pa_query_control -cv source $SOURCE_NAME 1 8000"
	su - app -c "XDG_RUNTIME_DIR=/run/user/5000 pa_query_control -cv source $SOURCE_NAME 1 0"
else
	pa_query_control -cv source $SOURCE_NAME 1 65536
	pa_query_control -cv source $SOURCE_NAME 1 40000
	pa_query_control -cv source $SOURCE_NAME 1 8000
	pa_query_control -cv source $SOURCE_NAME 1 0
fi

if [ $? -ne 0 ]; then
    echo "Error: failed to set source <$SOURCE_NAME> volume value"
    exit 1
fi

# Post: set back the source volume value
if [ $UID = 0 ];then
	su - app -c "XDG_RUNTIME_DIR=/run/user/5000 pa_query_control -cv source $SOURCE_NAME 1 $VOLUME"
else
	pa_query_control -cv source $SOURCE_NAME 1 $VOLUME
fi
exit 0

