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
#     Set default sink mute
# TIMEOUT: 30


. $(cd `dirname $0`;pwd)/env.sh

# Find the sink name and mute status
if [ $UID = 0 ];then
	SINK_NAME=`su - app -c "XDG_RUNTIME_DIR=/run/user/5000 pa_query_control -qs"|head -n 1 | awk -F, '{print $2}' | cut -d "=" -f2`
	MUTED=`su - app -c "XDG_RUNTIME_DIR=/run/user/5000 pa_query_control -qs" | head -n 1 | awk -F, '{print $5}' | cut -d "=" -f2`
else
	SINK_NAME=`pa_query_control -qs | awk -F, '{print $2}' | cut -d "=" -f2`
	MUTED=`pa_query_control -qs | awk -F, '{print $5}' | cut -d "=" -f2`
fi

if [ $? -ne 0 ]; then
    echo "Error: failed to find sink mute status"
    echo "Please check that if pulseaudio is running or if proper permission is granted"
    exit 1
fi

# Set sink muted
if [ $UID = 0 ];then
	su - app -c "XDG_RUNTIME_DIR=/run/user/5000 pa_query_control -cu sink $SINK_NAME 1"
else
	pa_query_control -cu sink $SINK_NAME 1 
fi

if [ $? -ne 0 ]; then
    echo "Error: failed to set sink <$SINK_NAME> mute"
    exit 1
fi

# Check sink mute status
if [ $UID = 0 ];then
	SETED=`su - app -c "XDG_RUNTIME_DIR=/run/user/5000 pa_query_control -qs" | head -n 1 | awk -F, '{print $5}' | cut -d "=" -f2`
else
	SETED=`pa_query_control -qs | awk -F, '{print $5}' | cut -d "=" -f2`
fi
if [ $SETED != "1" ]; then
    echo "Error: not set sink mute"
    exit 1
fi

# Post: set back the sink mute status
if [ $UID = 0 ];then
	su - app -c "XDG_RUNTIME_DIR=/run/user/5000 pa_query_control -cu sink $SINK_NAME $MUTED"
else
	pa_query_control -cu sink $SINK_NAME $MUTED    
fi
exit 0

