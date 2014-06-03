From: pwalmsley@nvidia.com (Paul Walmsley)
Date: Mon, 2 Jun 2014 23:46:31 -0700
Subject: Tegra baseline test results for v3.15-rc5
Message-ID: <538D6F47.6030801@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here are some basic Tegra test results for Linux v3.15-rc5.
Logs and other details at:

     http://nvt.pwsan.com/pub/linux/testlogs/test_v3.15-rc5/20140509133105/


Test summary
------------

Build: zImage:
     Pass: ( 2/ 2): multi_v7_defconfig, tegra_defconfig

Boot to userspace: multi_v7_defconfig:
     Pass: ( 2/ 2): tegra114-dalmore-a04, tegra30-beaver

Boot to userspace: tegra_defconfig:
     Pass: ( 2/ 2): tegra114-dalmore-a04, tegra30-beaver


vmlinux object size
(delta in bytes from test_v3.15-rc4 (89ca3b881987f5a4be4c5dbaa7f0df12bbdde2fd)):
    text     data      bss    total  kernel
    +359     +120        0     +479  multi_v7_defconfig
    +379     +128        0     +507  tegra_defconfig


Boot-time memory difference
(delta in bytes from test_v3.15-rc4 (89ca3b881987f5a4be4c5dbaa7f0df12bbdde2fd))
     avail    rsrvd     high    freed                board              kconfig                  dtb
         .        .        .        . tegra114-dalmore-a04   multi_v7_defconfig     tegra114-dalmore
         .        .        .        . tegra114-dalmore-a04      tegra_defconfig     tegra114-dalmore
         .        .        .        .       tegra30-beaver   multi_v7_defconfig       tegra30-beaver
         .        .        .        .       tegra30-beaver      tegra_defconfig       tegra30-beaver
