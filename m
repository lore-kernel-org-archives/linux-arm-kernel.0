From: pwalmsley@nvidia.com (Paul Walmsley)
Date: Mon, 30 Jun 2014 14:52:06 -0700
Subject: Tegra baseline test results for v3.16-rc2
Message-ID: <53B1DC06.8040308@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here are some basic Tegra test results for Linux v3.16-rc2.
Logs and other details at:

     http://nvt.pwsan.com/pub/linux/testlogs/test_v3.16-rc2/20140621223108/


Test summary
------------

Build: zImage:
     Pass: ( 2/ 2): multi_v7_defconfig, tegra_defconfig

Boot to userspace: multi_v7_defconfig:
     Pass: ( 2/ 2): tegra114-dalmore-a04, tegra30-beaver

Boot to userspace: tegra_defconfig:
     Pass: ( 2/ 2): tegra114-dalmore-a04, tegra30-beaver



vmlinux object size
(delta in bytes from test_v3.16-rc1 (7171511eaec5bf23fb06078f59784a3a0626b38f)):
    text     data      bss    total  kernel
  +27997    +1624        0   +29621  multi_v7_defconfig
    +766       -8        0     +758  tegra_defconfig


Boot-time memory difference
(delta in bytes from test_v3.16-rc1 (7171511eaec5bf23fb06078f59784a3a0626b38f))
     avail    rsrvd     high    freed                board              kconfig                  dtb
      -24k      24k        .     652k tegra114-dalmore-a04   multi_v7_defconfig     tegra114-dalmore
         .        .        .        . tegra114-dalmore-a04      tegra_defconfig     tegra114-dalmore
      -24k      24k        .     652k       tegra30-beaver   multi_v7_defconfig       tegra30-beaver
         .        .        .        .       tegra30-beaver      tegra_defconfig       tegra30-beaver
