From: pwalmsley@nvidia.com (Paul Walmsley)
Date: Wed, 1 Oct 2014 10:56:14 -0700
Subject: Tegra baseline test results for v3.17-rc4
Message-ID: <542C403E.6080608@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here are some basic Tegra test results for Linux v3.17-rc4.
Logs and other details at:

     http://nvt.pwsan.com/pub/linux/testlogs/test_v3.17-rc4/20141001101549/


Test summary
------------

Build: zImage:
     Pass: ( 2/ 2): multi_v7_defconfig, tegra_defconfig

Boot to userspace: multi_v7_defconfig:
     Pass: ( 3/ 3): tegra114-dalmore-a04, tegra124-jetson-tk1,
		   tegra30-beaver

Boot to userspace: tegra_defconfig:
     Pass: ( 3/ 3): tegra114-dalmore-a04, tegra124-jetson-tk1,
		   tegra30-beaver


vmlinux object size
(delta in bytes from test_v3.17-rc3 (69e273c0b0a3c337a521d083374c918dc52c666f)):
    text     data      bss    total  kernel
    +879        0        0     +879  multi_v7_defconfig
    +879        0        0     +879  tegra_defconfig


Boot-time memory difference
(delta in bytes from test_v3.17-rc3 (69e273c0b0a3c337a521d083374c918dc52c666f))
     avail    rsrvd     high    freed                board              kconfig                  dtb
         .        .        .        . tegra114-dalmore-a04   multi_v7_defconfig     tegra114-dalmore
         .        .        .        . tegra114-dalmore-a04      tegra_defconfig     tegra114-dalmore
         .        .        .        .  tegra124-jetson-tk1   multi_v7_defconfig  tegra124-jetson-tk1
         .        .        .        .  tegra124-jetson-tk1      tegra_defconfig  tegra124-jetson-tk1
         .        .        .        .       tegra30-beaver   multi_v7_defconfig       tegra30-beaver
         .        .        .        .       tegra30-beaver      tegra_defconfig       tegra30-beaver
