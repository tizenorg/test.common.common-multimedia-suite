#!/bin/bash
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.
#
# Authors: Nicolas Zingilé <nicolas.zingile@open.eurogiciel.org>

set -e
resdir=/tmp
resfile=$resdir/testkit.result.xml

echo '## execution script: preparing environment'
rm -rf $resdir/*.result.xml

timeout 10800 testkit-lite -f /usr/share/tests/common-multimedia-suite/testkit.xml --comm localhost -o $resfile

echo '## execution script: finished'