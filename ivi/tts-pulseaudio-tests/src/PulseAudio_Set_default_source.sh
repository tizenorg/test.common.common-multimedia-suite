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
# Set default source

# Modifications:
#          Modificator: shuang.wan@intel.com  Date: 2010-07-09
#          Content of Modification
#           1) Supplement the comments to the script file
#           2) Move the environment variables initlization to env.sh

. $(cd `dirname $0`;pwd)/env.sh
if [ $UID = 0 ];then
	su - app -c "XDG_RUNTIME_DIR=/run/user/5000 pa_query_control -cm load module-pipe-source source_name=test_source >  /tmp/test_result"
else
	pa_query_control -cm load module-pipe-source source_name=test_source >  "$TEST_RESULT"
fi

if [ $? -ne 0 ]; then
    echo "Failed to load module"
    exit 1
fi
cat  "$TEST_RESULT"
index=`cat  "$TEST_RESULT" | awk -F= '{print $2}'`
if [ $UID = 0 ];then
	su - app -c "XDG_RUNTIME_DIR=/run/user/5000 pa_query_control -cd source test_source"
else
	pa_query_control -cd source test_source
fi

if [ $? -ne 0 ]; then
    echo "Failed to set default source"
    exit 1
fi

if [ $UID = 0 ];then
	su - app -c "XDG_RUNTIME_DIR=/run/user/5000 pa_query_control -cm unload `cat /tmp/test_result|awk -F= '{print $2}'`"
else
	pa_query_control -cm unload $index
fi

if [ $? -ne 0 ]; then
    echo "Failed to unload module"
    exit 1
fi

rm -f "$TEST_RESULT"
