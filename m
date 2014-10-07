From: pwalmsley@nvidia.com (Paul Walmsley)
Date: Mon, 6 Oct 2014 21:58:46 -0700
Subject: Tegra baseline test results for v3.17
Message-ID: <54337306.6040807@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here are some basic Tegra test results for Linux v3.17.
Logs and other details at:

     http://nvt.pwsan.com/pub/linux/testlogs/test_v3.17/20141006214755/


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
(delta in bytes from test_v3.17-rc7 (fe82dcec644244676d55a1384c958d5f67979adb)):
    text     data      bss    total  kernel
     -57       -8       +8      -57  multi_v7_defconfig
     +91      +24       +4     +119  tegra_defconfig



Boot-time memory difference
(delta in bytes from test_v3.17-rc7 (fe82dcec644244676d55a1384c958d5f67979adb))
     avail    rsrvd     high    freed                board              kconfig                  dtb
         .        .        .        . tegra114-dalmore-a04   multi_v7_defconfig     tegra114-dalmore
         .        .        .        . tegra114-dalmore-a04      tegra_defconfig     tegra114-dalmore
         .        .        .        .  tegra124-jetson-tk1   multi_v7_defconfig  tegra124-jetson-tk1
         .        .        .        .  tegra124-jetson-tk1      tegra_defconfig  tegra124-jetson-tk1
         .        .        .        .       tegra30-beaver   multi_v7_defconfig       tegra30-beaver
         .        .        .        .       tegra30-beaver      tegra_defconfig       tegra30-beaver
