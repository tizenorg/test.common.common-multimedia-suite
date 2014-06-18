#!/bin/sh
#
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
#
# Authors:
#     Zhang, Zhiqiang <zhiqiang.zhang@intel.com>
#


DATA_PATH=$(cd `dirname $0`;pwd)/data
TEST_RESULT="/tmp/test_result"
RET=0

## below media files are needed but not include in this package, prepare them before run test ##

#setup a http server and put some media files on it:
HTTP=http://your.httpserver.com/media

# used in script:gstreamer_audio_playbin2_http_alaw.sh
## stored in http server
# wav audio: RIFF (little-endian) data, WAVE audio, ITU G.711 A-law, stereo 44100 Hz
GT_HTTP_AUDIO_ALAW="a-LAW_8bit_Stereo_44.1KHz_120sec\(10.1MB\)_AKM.wav"

# used in script:gstreamer_audio_playbin2_http_imaadpcm.sh
## stored in http server
# wav audio: RIFF (little-endian) data, WAVE audio, IMA ADPCM, stereo 32000 Hz 
GT_HTTP_IMAADPCM="IMAADPCM_4bit_Stereo_32KHz_256Kbps_60sec\(1.8Mb\).wav"

# used in script:gstreamer_audio_playbin2_http_ulaw.sh
## stored in http server
# wav audio: RIFF (little-endian) data, WAVE audio, ITU G.711 mu-law, stereo 44100 Hz
GT_HTTP_AUDIO_ULAW="u-LAW_8bit_Stereo_44.1KHz_120sec\(10MB\)_AKM.wav"

# used in script:gstreamer_video_http_ogg.sh
## stored in http server
# ogv video: kittens_240p.ogv: Ogg data, Skeleton v4.0
GT_HTTP_VIDEO_OGV="kittens_240p.ogv"

# used in script:gstreamer_audio_playbin2_imaadpcm_4bit_stereo_32khz_256kbps.sh
# wav audio: RIFF (little-endian) data, WAVE audio, IMA ADPCM, stereo 32000 Hz 
GT_IMAADPCM="/usr/share/tests/ivi-multimedia-tests/tts-gstreamer-tests/data/IMAADPCM_4bit_Stereo_32KHz_256Kbps_60sec\(1.8Mb\).wav"

# used in script:gstreamer_audio_playbin2_lpcm_16bit_stereo_44.1khz.sh
# wav audio: RIFF (little-endian) data, WAVE audio, Microsoft PCM, 16 bit, stereo 44100 Hz
GT_AUDIO_LPCM_16="/usr/share/tests/ivi-multimedia-tests/tts-gstreamer-tests/data/LPCM_16bit_Stereo_44.1KHz_60sec\(10Mb\).wav"

# used in script:gstreamer_audio_playbin2_lpcm_24bit_stereo_48khz.sh
# wav audio: RIFF (little-endian) data, WAVE audio, Microsoft PCM, 24 bit, stereo 48000 Hz
GT_AUDIO_LPCM_24="/usr/share/tests/ivi-multimedia-tests/tts-gstreamer-tests/data/LPCM_24bit_Stereo_48KHz_60sec\(16.8Mb\).wav"

# used in script:gstreamer_audio_playbin2_ogg_vorbis_16bit_mono_8khz_42kbps.sh
# ogg audio: Ogg data, Vorbis audio, mono, 8000 Hz, ~41997 bps
GT_OGG_MONO="/usr/share/tests/ivi-multimedia-tests/tts-gstreamer-tests/data/OGG_16bit_Mono_8KHz_42Kbps_2min\(0.5MB\).ogg"

# used in scripts:
# gstreamer_audio_avidemux.sh
# gstreamer_audio_pause_avidemux.sh
# gstreamer_audio_play_avidemux.sh
# gstreamer_audio_playbin2_alaw_8bit_stereo_44.1khz.sh
# gstreamer_audio_resume_avidemux.sh
# gstreamer_audio_resume_avidemux.sh
# gstreamer_audio_seek_avidemux.sh
# gstreamer_audio_stop_avidemux.sh
# avi audio: RIFF (little-endian) data, AVI, 0 x 0, >30 fps
GT_AUDIO_PCM_16="/usr/share/tests/ivi-multimedia-tests/tts-gstreamer-tests/data/PCM_16bit_Stereo_44.1KHz_1411Kbps_60sec.avi"

# used in script:gstreamer_image_jpegdec.sh
# jpeg file: JPEG image data, EXIF standard
GT_IMAGE_JPG="/usr/share/tests/ivi-multimedia-tests/tts-gstreamer-tests/data/butterfly.jpg"

# used in scripts:
# gstreamer_audio_alsasink.sh
# gstreamer_audio_pause_ogg.sh
# gstreamer_audio_play_ogg.sh
# gstreamer_audio_pulsesink.sh
# gstreamer_audio_resume_ogg.sh
# gstreamer_audio_seek_ogg.sh
# gstreamer_audio_stop_ogg.sh
# gstreamer_audio_vorbisdec.sh
# gstreamer_video_oggdemux.sh
# gstreamer_video_pause_oggdemux.sh
# gstreamer_video_playbin2_ogg_theora_vorbis.sh
# gstreamer_video_play_oggdemux.sh
# gstreamer_video_resume_oggdemux.sh
# gstreamer_video_seek_oggdemux.sh
# gstreamer_video_stop_oggdemux.sh
# gstreamer_video_theoradec.sh
# ogg video: Ogg data, Skeleton v4.0
GT_KITTENS="/usr/share/tests/ivi-multimedia-tests/tts-gstreamer-tests/data/kittens.ogg"

# used in script:gstreamer_image_pngdec.sh
# png file: PNG image data, 640 x 320, 8-bit/color RGB, non-interlaced
GT_IMAGE_PNG="/usr/share/tests/ivi-multimedia-tests/tts-gstreamer-tests/data/timer2.png"

# used in script:gstreamer_audio_playbin2_ulaw_8bit_stereo_44.1khz.sh
# wav audio: RIFF (little-endian) data, WAVE audio, ITU G.711 mu-law, stereo 44100 Hz
GT_AUDIO_ULAW="/usr/share/tests/ivi-multimedia-tests/tts-gstreamer-tests/data/u-LAW_8bit_Stereo_44.1KHz_120sec\(10MB\)_AKM.wav"

## END ##

export DISPLAY=:0.0
