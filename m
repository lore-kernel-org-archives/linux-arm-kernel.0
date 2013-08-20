From: pwalmsley@nvidia.com (Paul Walmsley)
Date: Tue, 20 Aug 2013 13:12:17 -0700
Subject: Tegra baseline test results for v3.11-rc6
Message-ID: <5213CDA1.4070906@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here are some basic Tegra test results for Linux v3.11-rc6.
Logs and other details at:

     http://nvt.pwsan.com/pub/linux/testlogs/test_v3.11-rc6/20130818150105/


Test summary
------------

Build: zImage:
     Pass: ( 2/ 2): multi_v7_defconfig, tegra_defconfig

Boot to userspace: multi_v7_defconfig:
     Pass: ( 2/ 2): tegra114-dalmore-headless, tegra30-beaver

Boot to userspace: tegra_defconfig:
     Pass: ( 2/ 2): tegra114-dalmore-headless, tegra30-beaver


vmlinux object size
(delta in bytes from test_v3.11-rc5 (d4e4ab86bcba5a72779c43dc1459f71fea3d89c8)):
    text     data      bss    total  kernel
   +1148        0        0    +1148  multi_v7_defconfig
    +728        0        0     +728  tegra_defconfig


Boot-time memory difference
(delta in bytes from test_v3.11-rc5 (d4e4ab86bcba5a72779c43dc1459f71fea3d89c8))
     avail    rsrvd     high    freed                board              kconfig                  dtb
         .        .        .        . tegra114-dalmore-hea   multi_v7_defconfig     tegra114-dalmore
         .        .        .        . tegra114-dalmore-hea      tegra_defconfig     tegra114-dalmore
         .        .        .        .       tegra30-beaver   multi_v7_defconfig       tegra30-beaver
         .        .        .        .       tegra30-beaver      tegra_defconfig       tegra30-beaver
