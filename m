From: pwalmsley@nvidia.com (Paul Walmsley)
Date: Mon, 2 Jun 2014 23:49:01 -0700
Subject: Tegra baseline test results for v3.15-rc7
Message-ID: <538D6FDD.6090604@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here are some basic Tegra test results for Linux v3.15-rc7.
Logs and other details at:

     http://nvt.pwsan.com/pub/linux/testlogs/test_v3.15-rc7/20140602173208/


Test summary
------------

Build: zImage:
     Pass: ( 2/ 2): multi_v7_defconfig, tegra_defconfig

Boot to userspace: multi_v7_defconfig:
     Pass: ( 2/ 2): tegra114-dalmore-a04, tegra30-beaver

Boot to userspace: tegra_defconfig:
     Pass: ( 2/ 2): tegra114-dalmore-a04, tegra30-beaver


vmlinux object size
(delta in bytes from test_v3.15-rc6 (4b660a7f5c8099d88d1a43d8ae138965112592c7)):
    text     data      bss    total  kernel
   +6161     +160     -144    +6177  multi_v7_defconfig
   +2838      +96     -264    +2670  tegra_defconfig


Boot-time memory difference
(delta in bytes from test_v3.15-rc6 (4b660a7f5c8099d88d1a43d8ae138965112592c7))
     avail    rsrvd     high    freed                board              kconfig                  dtb
       -8k       8k        .        . tegra114-dalmore-a04   multi_v7_defconfig     tegra114-dalmore
         .        .        .        . tegra114-dalmore-a04      tegra_defconfig     tegra114-dalmore
       -8k       8k        .        .       tegra30-beaver   multi_v7_defconfig       tegra30-beaver
         .        .        .        .       tegra30-beaver      tegra_defconfig       tegra30-beaver
