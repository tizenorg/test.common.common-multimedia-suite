#!/bin/bash
#
# Copyright (C) 2008-2011 Intel Corporation.
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU Lesser General Public
# License as published by the Free Software Foundation; either
# version 2.1 of the License, or (at your option) any later version.
#
# It is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# Lesser General Public License for more details.
#
# You should have received a copy of the GNU Lesser General Public
# License along with this software; if not, write to the Free
# Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
# 02111-1307 USA.
#                                                                                        
# Authors: 
#     Jessica JI < jessica.ji@intel.com >
#     Zhiqiang Zhang <zhiqiang.zhang@intel.com>
#
# DESCR:
#     Check http status of OGG Theora Vorbis format
#
# TIMEOUT: 200


. $(cd `dirname $0`;pwd)/env.sh

$(cd `dirname $0`;pwd)/playbin2.sh "$HTTP/${GT_HTTP_VIDEO_OGV}" 15

