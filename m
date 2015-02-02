From: pwalmsley@nvidia.com (Paul Walmsley)
Date: Mon, 2 Feb 2015 12:33:19 -0700
Subject: Tegra baseline test results for v3.19-rc7
Message-ID: <54CFD0FF.4060008@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here are some basic Tegra test results for Linux v3.19-rc7.
Logs and other details at:

     http://nvt.pwsan.com/pub/linux/testlogs/test_v3.19-rc7/20150201210104/


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
(delta in bytes from test_v3.19-rc6 (26bc420b59a38e4e6685a73345a0def461136dce)):
    text     data      bss    total  kernel
   -1192       -8        0    -1200  multi_v7_defconfig
   -1076      +72        0    -1004  tegra_defconfig


Boot-time memory difference
(delta in bytes from test_v3.19-rc6 (26bc420b59a38e4e6685a73345a0def461136dce))
     avail    rsrvd     high    freed                board              kconfig                  dtb
         .        .        .        . tegra114-dalmore-a04   multi_v7_defconfig     tegra114-dalmore
         .        .        .        . tegra114-dalmore-a04      tegra_defconfig     tegra114-dalmore
         .        .        .        .  tegra124-jetson-tk1   multi_v7_defconfig  tegra124-jetson-tk1
         .        .        .        .  tegra124-jetson-tk1      tegra_defconfig  tegra124-jetson-tk1
         .        .        .        .       tegra30-beaver   multi_v7_defconfig       tegra30-beaver
         .        .        .        .       tegra30-beaver      tegra_defconfig       tegra30-beaver
