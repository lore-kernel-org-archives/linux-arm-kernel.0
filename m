From: pwalmsley@nvidia.com (Paul Walmsley)
Date: Mon, 8 Dec 2014 15:51:20 -0700
Subject: Tegra baseline test results for v3.18
Message-ID: <54862B68.8070106@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here are some basic Tegra test results for Linux v3.18.
Logs and other details at:

     http://nvt.pwsan.com/pub/linux/testlogs/test_v3.18/20141208122141/


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
(delta in bytes from test_v3.18-rc7 (009d0431c3914de64666bec0d350e54fdd59df6a)):
    text     data      bss    total  kernel
     -87      -16        0     -103  multi_v7_defconfig
    -119       -8        0     -127  tegra_defconfig


Boot-time memory difference
(delta in bytes from test_v3.18-rc7 (009d0431c3914de64666bec0d350e54fdd59df6a))
     avail    rsrvd     high    freed                board              kconfig                  dtb
         .        .        .        . tegra114-dalmore-a04   multi_v7_defconfig     tegra114-dalmore
         .        .        .        . tegra114-dalmore-a04      tegra_defconfig     tegra114-dalmore
         .        .        .        .  tegra124-jetson-tk1   multi_v7_defconfig  tegra124-jetson-tk1
         .        .        .        .  tegra124-jetson-tk1      tegra_defconfig  tegra124-jetson-tk1
         .        .        .        .       tegra30-beaver   multi_v7_defconfig       tegra30-beaver
         .        .        .        .       tegra30-beaver      tegra_defconfig       tegra30-beaver
