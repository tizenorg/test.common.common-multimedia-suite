#!/bin/sh
#
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
#
# Authors:
#       Wan Shuang  <shuang.wan@intel.com>
# Date Created: 2010/07/08
#
# Modifications:
#          Modificator  Date
#          Content of Modification
#

UTILS_PATH=$(cd `dirname $0`;pwd)
DATA_PATH=$(cd `dirname $0`;pwd)/data
TEST_RESULT="/tmp/test_result"

## below media files are needed but not include in this package, prepare them before run test ##

# used in script: PulseAudio_Play_PCM_16bit_Multichannel_48KHz.sh
# wav audio: RIFF (little-endian) data, WAVE audio, 6 channels 48000 Hz
MF_TEST_48K="/opt/tts-pulseaudio-tests/data/PCM_16bit_5.1_48KHz_4608Kbps_38sec.wav"

# used in script: PulseAudio_Play_PCM_16bit_Mono_8KHz.sh
# wav audio: RIFF (little-endian) data, WAVE audio, Microsoft PCM, 16 bit, mono 8000 Hz
MF_TEST_8K="/opt/tts-pulseaudio-tests/data/PCM_16bit_Mono_8KHz_128Kbps_60sec.wav"

# used in script: PulseAudio_Play_PCM_16bit_Stereo_44.1KHz.sh/PulseAudio_Play_PCM_2_streams.sh
# wav audio: RIFF (little-endian) data, WAVE audio, Microsoft PCM, 16 bit, stereo 44100 Hz 
MF_TEST_44K_1="/opt/tts-pulseaudio-tests/data/PCM_16bit_Stereo_44.1KHz_1411Kbps_10s.WAV"

# used in script: PulseAudio_Play_PCM_2_streams.sh
# wav audio: RIFF (little-endian) data, WAVE audio, Microsoft PCM, 16 bit, stereo 44100 Hz
MF_TEST_44K_2="/opt/tts-pulseaudio-tests/data/PCM_16bit_Stereo_44.1KHz_1412.2Kbps_60sec.wav"

# used in script: PulseAudio_Check_sample_cache.sh/PulseAudio_Play_PCM_stress_repeat.sh
# wav audio: RIFF (little-endian) data, WAVE audio, Microsoft PCM, 16 bit, mono 8000 Hz
MF_TEST_WAV="/opt/tts-pulseaudio-tests/data/test.wav"

## END ##

export PATH=$PATH:/sbin/:/usr/sbin/
