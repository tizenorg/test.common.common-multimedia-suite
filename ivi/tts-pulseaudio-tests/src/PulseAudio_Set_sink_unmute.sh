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
#     Set default sink unmute
# TIMEOUT: 30


. $(cd `dirname $0`;pwd)/env.sh

# Find the sink name and mute status
if [ $UID = 0 ];then
	SINK_NAME=`su - app -c "XDG_RUNTIME_DIR=/run/user/5000  /opt/tts-pulseaudio-tests/pa_query_control -qs" |grep -i 'alsa_output' | awk -F, '{print $2}' | cut -d "=" -f2`
	MUTED=`su - app -c "XDG_RUNTIME_DIR=/run/user/5000  /opt/tts-pulseaudio-tests/pa_query_control -qs" |grep -i 'alsa_output' | awk -F, '{print $5}' | cut -d "=" -f2`
else
	SINK_NAME=`$UTILS_PATH/pa_query_control -qs | awk -F, '{print $2}' | cut -d "=" -f2`
	MUTED=`$UTILS_PATH/pa_query_control -qs | awk -F, '{print $5}' | cut -d "=" -f2`
fi

if [ $? -ne 0 ]; then
    echo "Error: failed to find sink mute status"
    echo "Please check that if pulseaudio is running or if proper permission is granted"
    exit 1
fi

# Set sink unmute
if [ $UID = 0 ];then
	su - app -c "XDG_RUNTIME_DIR=/run/user/5000  /opt/tts-pulseaudio-tests/pa_query_control -cu sink $SINK_NAME 0"
else
	$UTILS_PATH/pa_query_control -cu sink $SINK_NAME 0 
fi

if [ $? -ne 0 ]; then
    echo "Error: failed to set sink <$SINK_NAME> unmute"
    exit 1
fi

# Check sink mute status
if [ $UID = 0 ];then
	SETED=`su - app -c "XDG_RUNTIME_DIR=/run/user/5000  /opt/tts-pulseaudio-tests/pa_query_control -qs" |grep -i 'alsa_output' | awk -F, '{print $5}' | cut -d "=" -f2`
else
	SETED=`$UTILS_PATH/pa_query_control -qs | awk -F, '{print $5}' | head -n 1 |cut -d "=" -f2`
fi

if [ "X$SETED" != "X0" ]; then
    echo "Error: not set sink unmute"
    exit 1
fi

# Post: set back the sink mute status
if [ $UID = 0 ];then
	su - app -c "XDG_RUNTIME_DIR=/run/user/5000  /opt/tts-pulseaudio-tests/pa_query_control -cu sink $SINK_NAME $MUTED"
else
	$UTILS_PATH/pa_query_control -cu sink $SINK_NAME $MUTED    
fi
exit 0

