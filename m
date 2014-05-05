From: pwalmsley@nvidia.com (Paul Walmsley)
Date: Mon, 5 May 2014 12:59:10 -0700
Subject: Tegra baseline test results for v3.15-rc4
Message-ID: <5367ED8E.7030201@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here are some basic Tegra test results for Linux v3.15-rc4.
Logs and other details at:

     http://nvt.pwsan.com/pub/linux/testlogs/test_v3.15-rc4/20140504183106/


Test summary
------------

Build: zImage:
     Pass: ( 2/ 2): multi_v7_defconfig, tegra_defconfig

Boot to userspace: multi_v7_defconfig:
     Pass: ( 2/ 2): tegra114-dalmore-a04, tegra30-beaver

Boot to userspace: tegra_defconfig:
     Pass: ( 2/ 2): tegra114-dalmore-a04, tegra30-beaver



vmlinux object size
(delta in bytes from test_v3.15-rc3 (d1db0eea852497762cab43b905b879dfcd3b8987)):
    text     data      bss    total  kernel
    +428       +8        0     +436  multi_v7_defconfig
    +376      +24        0     +400  tegra_defconfig


Boot-time memory difference
(delta in bytes from test_v3.15-rc3 (d1db0eea852497762cab43b905b879dfcd3b8987))
     avail    rsrvd     high    freed                board              kconfig                  dtb
         .        .        .        . tegra114-dalmore-a04   multi_v7_defconfig     tegra114-dalmore
         .        .        .        . tegra114-dalmore-a04      tegra_defconfig     tegra114-dalmore
         .        .        .        .       tegra30-beaver   multi_v7_defconfig       tegra30-beaver
         .        .        .        .       tegra30-beaver      tegra_defconfig       tegra30-beaver
