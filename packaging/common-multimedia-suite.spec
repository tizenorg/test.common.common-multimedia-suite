%define _unpackaged_files_terminate_build 0

Name: common-multimedia-suite
Summary: common-multimedia-suite
Version: 0.1.0
Release: 1
License: GPLv2
Group: Development/Testing
Source0: %{name}-%{version}.tar.gz

BuildRequires: pkgconfig(gstreamer-1.0)
BuildRequires: pkgconfig(gstreamer-base-1.0)
BuildRequires: pkgconfig(gthread-2.0)

%description
This package is IVI common mutlimedia test suite

%package -n tts-pulseaudio-tests
Summary: Pulseaudio test suit   
Group:   Development/Testing

%description -n tts-pulseaudio-tests
%{summary}.


%package -n tts-gstreamer-tests
Summary: Gstreamer test suit   
Group:   Development/Testing

%description -n tts-gstreamer-tests
%{summary}.



%package -n gst-auto-launch
Summary: Improved version of gst-launch
Group:   Development/Testing/Tool

%description -n gst-auto-launch
gst-auto-launch is an improved version of gst-launch that accepts commands

%prep
%setup -q

%build
./autogen.sh
./configure --prefix=/usr
make

%install

rm -rf $RPM_BUILD_ROOT
make install DESTDIR=$RPM_BUILD_ROOT

install -d %{buildroot}/%{_datadir}/tests/%{name}/tts-pulseaudio-tests
install -m 0755 ivi/tts-pulseaudio-tests/src/* %{buildroot}/%{_datadir}/tests/%{name}/tts-pulseaudio-tests
install -m 0755 ivi/tts-pulseaudio-tests/tests.xml %{buildroot}/%{_datadir}/tests/%{name}/tts-pulseaudio-tests
install -m 0755 ivi/tts-pulseaudio-tests/README %{buildroot}/%{_datadir}/tests/%{name}/tts-pulseaudio-tests
install LICENSE %{buildroot}/%{_datadir}/tests/%{name}/tts-pulseaudio-tests

install -d %{buildroot}/%{_datadir}/tests/%{name}/tts-gstreamer-tests
install -m 0755 ivi/tts-gstreamer-tests/src/* %{buildroot}/%{_datadir}/tests/%{name}/tts-gstreamer-tests
install -m 0755 ivi/tts-gstreamer-tests/tests.xml %{buildroot}/%{_datadir}/tests/%{name}/tts-gstreamer-tests
install -m 0755 ivi/tts-gstreamer-tests/README %{buildroot}/%{_datadir}/tests/%{name}/tts-gstreamer-tests
install LICENSE %{buildroot}/%{_datadir}/tests/%{name}/tts-gstreamer-tests



%clean
rm -rf $RPM_BUILD_ROOT


%files -n tts-pulseaudio-tests
%defattr(-,root,root)
%{_datadir}/tests/%{name}/tts-pulseaudio-tests
%license LICENSE

%files -n tts-gstreamer-tests
%defattr(-,root,root)
%{_datadir}/tests/%{name}/tts-gstreamer-tests
%license LICENSE

%files -n gst-auto-launch
%defattr(-,root,root)
/usr/bin/gst-auto-launch
%{_datadir}/gst-auto-launch
%license LICENSE

%changelog
* Thu Nov 2 2012  Wu dawei<daweix.wu@intel.com> 0.1.0-1
 - Initial common multimedia suite test

