From: pwalmsley@nvidia.com (Paul Walmsley)
Date: Wed, 1 Oct 2014 11:29:01 -0700
Subject: Tegra baseline test results for v3.17-rc7
Message-ID: <542C47ED.9050502@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here are some basic Tegra test results for Linux v3.17-rc7.
Logs and other details at:

     http://nvt.pwsan.com/pub/linux/testlogs/test_v3.17-rc7/20141001111649/


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
(delta in bytes from test_v3.17-rc6 (0f33be009b89d2268e94194dc4fd01a7851b6d51)):
    text     data      bss    total  kernel
    +703        0        0     +703  multi_v7_defconfig
    +175        0        0     +175  tegra_defconfig


Boot-time memory difference
(delta in bytes from test_v3.17-rc6 (0f33be009b89d2268e94194dc4fd01a7851b6d51))
     avail    rsrvd     high    freed                board              kconfig                  dtb
         .        .        .        . tegra114-dalmore-a04   multi_v7_defconfig     tegra114-dalmore
         .        .        .        . tegra114-dalmore-a04      tegra_defconfig     tegra114-dalmore
         .        .        .        .  tegra124-jetson-tk1   multi_v7_defconfig  tegra124-jetson-tk1
         .        .        .        .  tegra124-jetson-tk1      tegra_defconfig  tegra124-jetson-tk1
         .        .        .        .       tegra30-beaver   multi_v7_defconfig       tegra30-beaver
         .        .        .        .       tegra30-beaver      tegra_defconfig       tegra30-beaver
