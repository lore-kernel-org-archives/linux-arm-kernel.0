From: gnusercn@gmail.com (os user)
Date: Wed, 14 Jul 2010 16:59:23 +0800
Subject: [Bug] make ARCH=arm menuconfig is abnormal due to commit ID:
	63b1f51b2405573d47bf5b9ab6e7cd5c697d3dcc
Message-ID: <AANLkTinreCm2ioVWpjknDMwGNhDRlqyENJuOkUZhsB_I@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

I found since the commit ID: 63b1f51b2405573d47bf5b9ab6e7cd5c697d3dcc

$ make ARCH=arm menuconfig

is abnormal:

Items in [System Type --> ARM system type (xxxx) -->] can not be
displayed correctly. It seems the line,

<snip>
bool "Samsung S3C2410, S3C2412, S3C2413, S3C2416, S3C2440, S3C2442,
S3C2443, S3C2450"
</snip>

is too long.

My host machine is,

Ubuntu 8.10
Intel(R) Pentium(R) 4 CPU 2.80GHz

$ gcc --version
gcc (Ubuntu 4.3.2-1ubuntu12) 4.3.2
Copyright (C) 2008 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

BR
