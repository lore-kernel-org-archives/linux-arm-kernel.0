From: mikpelinux@gmail.com (Mikael Pettersson)
Date: Thu, 21 Sep 2017 09:53:27 +0200
Subject: Possible gcc 4.8.5 bug about RELOC_HIDE marcro
In-Reply-To: <03f619bd-e3b2-49e0-5f2c-e232974eac12@gmail.com>
References: <03f619bd-e3b2-49e0-5f2c-e232974eac12@gmail.com>
Message-ID: <22979.28663.77963.862263@gargle.gargle.HOWL>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jia He writes:
 > I tried to build kernel 4.14-rc1 on a arm64 server in distro centos 7.3. 
 > The gcc version is 4.8.5

I have no input on the specifics of the issue, but please note that gcc-4.8
is no longer supported or maintained by upstream.  Even gcc-4.9 is EOL, and
gcc-5 will be EOL:d inn a week or so.  Also I'll note that gcc-4.8 is still
fairly early wrt to arm64 support, so bugs may be expected.

In short, please retry with gcc-6.4 or gcc-7.2.
