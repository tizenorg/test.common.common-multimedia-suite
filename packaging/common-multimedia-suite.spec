Name:		common-multimedia-suite
Summary:	Multimedia suite for Tizen Common
Version:	1.0.0
Release:	1
License:	GPL-2.0
Group:		Development/Testing
Source0:	%{name}-%{version}.tar.gz
Source1001:	%{name}.manifest
BuildRequires:	pkgconfig(gstreamer-1.0)
BuildRequires:	pkgconfig(gstreamer-base-1.0)
BuildRequires:	pkgconfig(gthread-2.0)
Requires:	common-suite-launcher
Requires:	testkit-lite
    
%description
The common-multimedia-suite validates the multimedia features of the Tizen Common image : audio and video playing of media files of different formats with gstreamer


%package -n ivi-multimedia-tests
Summary:	IVI multimedia test suite  
Group:		Development/Testing
Requires:	gstreamer-utils
Requires:	pulseaudio-utils
Requires:	testkit-lite

%description -n ivi-multimedia-tests
IVI multimedia test suite. Validates gstreamer and pulseaudio features


%package -n gst-auto-launch
Summary:	Improved version of gst-launch
Group:		Development/Testing
Requires:	gstreamer-utils

%description -n gst-auto-launch
gst-auto-launch is an improved version of gst-launch that accepts commands


%prep
%setup -q
cp %{SOURCE1001} .


%build
%reconfigure \
    --prefix=%{_prefix}
%__make %{?_smp_mflags}


%install
%make_install

# common-multimedia-suite package 
install -d %{buildroot}/%{_datadir}/tests/%{name}
install -m 0755 common/runtest.sh %{buildroot}/%{_datadir}/tests/%{name}
install -m 0644 common/*.xml %{buildroot}/%{_datadir}/tests/%{name}
install -m 0644 LICENSE %{buildroot}/%{_datadir}/tests/%{name}
cp -r common/TESTDIR %{buildroot}/%{_datadir}/tests/%{name}

# ivi-multimedia-tests package
install -d %{buildroot}/%{_datadir}/tests/ivi-multimedia-tests/tts-gstreamer-tests
install -d %{buildroot}/%{_datadir}/tests/ivi-multimedia-tests/tts-pulseaudio-tests
install -m 0755 ivi/tts-gstreamer-tests/src/* %{buildroot}/%{_datadir}/tests/ivi-multimedia-tests/tts-gstreamer-tests
install -m 0644 ivi/tts-gstreamer-tests/tests.xml %{buildroot}/%{_datadir}/tests/ivi-multimedia-tests/tts-gstreamer-tests
install -m 0644 ivi/tts-gstreamer-tests/README %{buildroot}/%{_datadir}/tests/ivi-multimedia-tests/tts-gstreamer-tests
install -m 0755 ivi/tts-pulseaudio-tests/src/*.sh %{buildroot}/%{_datadir}/tests/ivi-multimedia-tests/tts-pulseaudio-tests
install -m 0644 ivi/tts-pulseaudio-tests/tests.xml %{buildroot}/%{_datadir}/tests/ivi-multimedia-tests/tts-pulseaudio-tests
install -m 0644 ivi/tts-pulseaudio-tests/README %{buildroot}/%{_datadir}/tests/ivi-multimedia-tests/tts-pulseaudio-tests
install -m 0644 LICENSE %{buildroot}/%{_datadir}/tests/ivi-multimedia-tests

%files 
%manifest %{name}.manifest
%defattr(-,root,root)
%{_datadir}/tests/%{name}


%files -n ivi-multimedia-tests
%defattr(-,root,root)
%{_datadir}/tests/ivi-multimedia-tests


%files -n gst-auto-launch
%defattr(-,root,root)
%{_bindir}/gst-auto-launch
%{_datadir}/gst-auto-launch
