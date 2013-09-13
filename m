From: olof@lixom.net (Olof Johansson)
Date: Thu, 12 Sep 2013 17:24:48 -0700
Subject: More build reports
Message-ID: <CAOesGMh3LSR_VN_sdo55ttaXn6Z_LUuoYXLCuhgMYY488Qwvvg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I've been sending only myself and Kevin the build reports from my own
builder, but since there seems to be interest for this I'll include
them on the kernel-build-reports list as well.

I build the following trees on a regular basis, i.e. polling for
updates multiple times an hour:

arm-soc for-next
mainline master
linux-next master
arm-soc to-build, which we use to get a build iteration out of before
we push it to for-next sometimes
"queue", which is linux-stable -rc queues, currently 3.9.y - 3.11.y.

I boot them on a selection of boards:

* Cubie
* Cubie2
* Cubox
* Panda ES (omap2plus_defconfig and multi_v7_defconfig)
* Arndale
* Atmel SAMA5
* Tegra3 Beaver (tegra_defconfig and multi_v7_defconfig)
* STE Snowball (u8500_defconfig and multi_v7_defconfig [known broken])

More hardware will be added over time as I buy it (or receive it from
generous hardware vendors). Beaglebone black and an A31 eval board
from Allwinner still need to be added, for example. I also have a
seemingly broken Wandboard Quad that I'll get replaced and added back
in.


-Olof
