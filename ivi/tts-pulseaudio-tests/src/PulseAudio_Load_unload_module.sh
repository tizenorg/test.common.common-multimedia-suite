#!/bin/bash
# Copyright (C) 2010 Intel Corporation
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
#       Chen, Hao  <hao.h.chen@intel.com>
#
# load module, unload module 

# Modifications:
#          Modificator: shuang.wan@intel.com  Date: 2010-07-09
#          Content of Modification
#           1) Supplement the comments to the script file
#           2) Move the environment variables initlization to env.sh

. $(cd `dirname $0`;pwd)/env.sh
if [ $UID = 0 ];then
	su - app -c "XDG_RUNTIME_DIR=/run/user/5000 pa_query_control -cm load module-null-sink sink_name=pa_test_sink > /tmp/test_result"
else
	pa_query_control -cm load module-null-sink sink_name=pa_test_sink > "$TEST_RESULT"
fi

if [ $? -ne 0 ]; then
    echo "Failed to load module"
    exit 1
fi
cat "$TEST_RESULT"

index=`cat "$TEST_RESULT" | awk -F= '{print $2}'`
if [ $UID = 0 ];then
	su - app -c "XDG_RUNTIME_DIR=/run/user/5000 pa_query_control -qm"
else
	pa_query_control -qm
fi

if [ $? -ne 0 ]; then
    echo "Failed to query modules"
    exit 1
fi
if [ $UID = 0 ];then
	su - app -c "XDG_RUNTIME_DIR=/run/user/5000 pa_query_control -cm unload `cat /tmp/test_result|awk -F= '{print $2}'`"
else
	pa_query_control -cm unload $index
fi

if [ $? -ne 0 ]; then
    echo "Failed to unload modules"
    exit 1

fi

rm "$TEST_RESULT"
