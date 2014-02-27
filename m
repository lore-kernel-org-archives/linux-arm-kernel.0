From: pwalmsley@nvidia.com (Paul Walmsley)
Date: Thu, 27 Feb 2014 02:48:30 -0800
Subject: Tegra baseline test results for v3.14-rc2
Message-ID: <530F17FE.4010408@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here are some basic Tegra test results for Linux v3.14-rc2.
Logs and other details at:

     http://nvt.pwsan.com/pub/linux/testlogs/test_v3.14-rc2/20140227023319/


Test summary
------------

Build: zImage:
     Pass: ( 2/ 2): multi_v7_defconfig, tegra_defconfig

Boot to userspace: multi_v7_defconfig:
     Pass: ( 2/ 2): tegra114-dalmore-a04, tegra30-beaver

Boot to userspace: tegra_defconfig:
     Pass: ( 2/ 2): tegra114-dalmore-a04, tegra30-beaver



vmlinux object size
(delta in bytes from test_v3.14-rc1 (38dbfb59d1175ef458d006556061adeaa8751b72)):
    text     data      bss    total  kernel
    +609      +64        0     +673  multi_v7_defconfig
    +689       -8        0     +681  tegra_defconfig


Boot-time memory difference
(delta in bytes from test_v3.14-rc1 (38dbfb59d1175ef458d006556061adeaa8751b72))
     avail    rsrvd     high    freed                board              kconfig                  dtb
         .        .        .        . tegra114-dalmore-a04   multi_v7_defconfig     tegra114-dalmore
         .        .        .        . tegra114-dalmore-a04      tegra_defconfig     tegra114-dalmore
         .        .        .        .       tegra30-beaver   multi_v7_defconfig       tegra30-beaver
         .        .        .        .       tegra30-beaver      tegra_defconfig       tegra30-beaver
