From: pwalmsley@nvidia.com (Paul Walmsley)
Date: Mon, 4 Aug 2014 03:00:29 -0700
Subject: Tegra baseline test results for v3.16
Message-ID: <53DF59BD.1000203@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here are some basic Tegra test results for Linux v3.16.
Logs and other details at:

     http://nvt.pwsan.com/pub/linux/testlogs/test_v3.16/20140804004249/


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
(delta in bytes from test_v3.16-rc7 (64aa90f26c06e1cb2aacfb98a7d0eccfbd6c1a91)):
    text     data      bss    total  kernel
   +4636      +16        0    +4652  multi_v7_defconfig
   +4280       +8        0    +4288  tegra_defconfig


Boot-time memory difference
(delta in bytes from test_v3.16-rc7 (64aa90f26c06e1cb2aacfb98a7d0eccfbd6c1a91))
     avail    rsrvd     high    freed                board              kconfig                  dtb
         .        .        .        . tegra114-dalmore-a04   multi_v7_defconfig     tegra114-dalmore
         .        .        .        . tegra114-dalmore-a04      tegra_defconfig     tegra114-dalmore
         .        .        .        .  tegra124-jetson-tk1   multi_v7_defconfig  tegra124-jetson-tk1
         .        .        .        .  tegra124-jetson-tk1      tegra_defconfig  tegra124-jetson-tk1
         .        .        .        .       tegra30-beaver   multi_v7_defconfig       tegra30-beaver
         .        .        .        .       tegra30-beaver      tegra_defconfig       tegra30-beaver
