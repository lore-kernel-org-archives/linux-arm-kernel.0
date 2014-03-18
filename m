From: pwalmsley@nvidia.com (Paul Walmsley)
Date: Mon, 17 Mar 2014 23:30:30 -0700
Subject: Tegra baseline test results for v3.14-rc7
Message-ID: <5327E806.3010108@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here are some basic Tegra test results for Linux v3.14-rc7.
Logs and other details at:

     http://nvt.pwsan.com/pub/linux/testlogs/test_v3.14-rc7/20140317231219/


Test summary
------------

Build: zImage:
     Pass: ( 2/ 2): multi_v7_defconfig, tegra_defconfig

Boot to userspace: multi_v7_defconfig:
     Pass: ( 2/ 2): tegra114-dalmore-a04, tegra30-beaver

Boot to userspace: tegra_defconfig:
     Pass: ( 2/ 2): tegra114-dalmore-a04, tegra30-beaver



vmlinux object size
(delta in bytes from test_v3.14-rc6 (fa389e220254c69ffae0d403eac4146171062d08)):
    text     data      bss    total  kernel
    -595     -128        0     -723  multi_v7_defconfig
    -523     -128        0     -651  tegra_defconfig


Boot-time memory difference
(delta in bytes from test_v3.14-rc6 (fa389e220254c69ffae0d403eac4146171062d08))
     avail    rsrvd     high    freed                board              kconfig                  dtb
       -8k       8k        .        . tegra114-dalmore-a04   multi_v7_defconfig     tegra114-dalmore
         .        .        .        . tegra114-dalmore-a04      tegra_defconfig     tegra114-dalmore
       -8k       8k        .        .       tegra30-beaver   multi_v7_defconfig       tegra30-beaver
         .        .        .        .       tegra30-beaver      tegra_defconfig       tegra30-beaver
