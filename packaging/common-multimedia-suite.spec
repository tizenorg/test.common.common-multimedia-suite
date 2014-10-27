Name:           common-multimedia-suite
Summary:        Multimedia suite for Tizen Common
Version:        1.1
Release:        0
License:        GPL-2.0
Group:          Development/Testing
Source0:        %{name}-%{version}.tar.gz
Source1001:     %{name}.manifest
BuildRequires:  pkgconfig(gstreamer-1.0)
BuildRequires:  pkgconfig(gthread-2.0)
Requires:       common-suite-launcher
Requires:       gst-plugins-base
Requires:       gstreamer-utils
Requires:       testkit-lite
BuildArch:      noarch

%description
The common-multimedia-suite validates the multimedia features of the
Tizen Common image : audio and video playing of media files of different
formats with gstreamer

%prep
%setup -q
cp %{SOURCE1001} .

%build
#empty

%install
install -d %{buildroot}/%{_datadir}/tests/common/%{name}
install -m 0755 runtest %{buildroot}/%{_datadir}/tests/common/%{name}
install -m 0644 *.xml %{buildroot}/%{_datadir}/tests/common/%{name}
cp -r TESTDIR %{buildroot}/%{_datadir}/tests/common/%{name}

%files
%manifest %{name}.manifest
%defattr(-,root,root)
%license LICENSE
%license LICENSE.CC-BY-3.0
%{_datadir}/tests/common/%{name}
