From: pwalmsley@nvidia.com (Paul Walmsley)
Date: Mon, 23 Jun 2014 16:57:43 -0700
Subject: Tegra baseline test results for v3.16-rc1
Message-ID: <53A8BEF7.5090304@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Here are some basic Tegra test results for Linux v3.16-rc1.
Logs and other details at:

     http://nvt.pwsan.com/pub/linux/testlogs/test_v3.16-rc1/20140615210102/


Test summary
------------

Build: zImage:
     Pass: ( 2/ 2): multi_v7_defconfig, tegra_defconfig

Boot to userspace: multi_v7_defconfig:
     FAIL: ( 2/ 2): tegra114-dalmore-a04, tegra30-beaver

Boot to userspace: tegra_defconfig:
     Pass: ( 2/ 2): tegra114-dalmore-a04, tegra30-beaver



vmlinux object size
(delta in bytes from test_v3.15 (1860e379875dfe7271c649058aeddffe5afd9d0d)):
    text     data      bss    total  kernel
+438973  +168256   +14472  +621701  multi_v7_defconfig
+136940     -408   +12724  +149256  tegra_defconfig


Boot-time memory difference
(delta in bytes from test_v3.15 (1860e379875dfe7271c649058aeddffe5afd9d0d))
     avail    rsrvd     high    freed                board              kconfig                  dtb
     -636k     636k        .    -548k tegra114-dalmore-a04   multi_v7_defconfig     tegra114-dalmore
     -148k     148k        .       4k tegra114-dalmore-a04      tegra_defconfig     tegra114-dalmore
     -636k     636k        .    -548k       tegra30-beaver   multi_v7_defconfig       tegra30-beaver
     -148k     148k        .       4k       tegra30-beaver      tegra_defconfig       tegra30-beaver
