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
#     Set default sink vloume value
# TIMEOUT: 30


. $(cd `dirname $0`;pwd)/env.sh

# Find the sink name and volume value
if [ $UID = 0 ];then
	SINK_NAME=`su - app -c "XDG_RUNTIME_DIR=/run/user/5000 pa_query_control -qs" | head -n 1 | awk -F, '{print $2}' | cut -d "=" -f2`
	VOLUME=`su - app -c "XDG_RUNTIME_DIR=/run/user/5000 pa_query_control -qs" | head -n 1| awk -F, '{print $4}' | cut -d "=" -f2 | awk '{print $2}'`
else
	SINK_NAME=`pa_query_control -qs | head -n 1 | awk -F, '{print $2}' | cut -d "=" -f2`
	VOLUME=`pa_query_control -qs | head -n 1| awk -F, '{print $4}' | cut -d "=" -f2 | awk '{print $2}'`
fi

if [ $? -ne 0 ]; then
    echo "Error: failed to find sink volume value"
    echo "Please check that if pulseaudio is running or if proper permission is granted"
    exit 1
fi

# Set sink volume value for the 1st channel
if [ $UID = 0 ];then
	su - app -c "XDG_RUNTIME_DIR=/run/user/5000 pa_query_control -cv sink $SINK_NAME 1 0"
	su - app -c "XDG_RUNTIME_DIR=/run/user/5000 pa_query_control -cv sink $SINK_NAME 1 1000"
	su - app -c "XDG_RUNTIME_DIR=/run/user/5000 pa_query_control -cv sink $SINK_NAME 1 30000"
	su - app -c "XDG_RUNTIME_DIR=/run/user/5000 pa_query_control -cv sink $SINK_NAME 1 65536"
else
	pa_query_control -cv sink $SINK_NAME 1 0
	pa_query_control -cv sink $SINK_NAME 1 1000
	pa_query_control -cv sink $SINK_NAME 1 30000
	pa_query_control -cv sink $SINK_NAME 1 65536
fi

if [ $? -ne 0 ]; then
    echo "Error: failed to set sink <$SINK_NAME> volume value"
    exit 1
fi

# Post: set back the sink volume value
if [ $UID = 0 ];then
	su - app -c "XDG_RUNTIME_DIR=/run/user/5000 pa_query_control -cv sink $SINK_NAME 1 $VOLUME"
else
	pa_query_control -cv sink $SINK_NAME 1 $VOLUME
fi
exit 0

