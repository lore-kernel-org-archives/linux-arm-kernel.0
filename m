From: pwalmsley@nvidia.com (Paul Walmsley)
Date: Mon, 2 Jun 2014 23:47:46 -0700
Subject: Tegra baseline test results for v3.15-rc6
Message-ID: <538D6F92.2020206@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here are some basic Tegra test results for Linux v3.15-rc6.
Logs and other details at:

     http://nvt.pwsan.com/pub/linux/testlogs/test_v3.15-rc6/20140602172452/


Test summary
------------

Build: zImage:
     Pass: ( 2/ 2): multi_v7_defconfig, tegra_defconfig

Boot to userspace: multi_v7_defconfig:
     Pass: ( 2/ 2): tegra114-dalmore-a04, tegra30-beaver

Boot to userspace: tegra_defconfig:
     Pass: ( 2/ 2): tegra114-dalmore-a04, tegra30-beaver



vmlinux object size
(delta in bytes from test_v3.15-rc5 (d6d211db37e75de2ddc3a4f979038c40df7cc79c)):
    text     data      bss    total  kernel
   +1396     -392        0    +1004  multi_v7_defconfig
    +916      +48        0     +964  tegra_defconfig


Boot-time memory difference
(delta in bytes from test_v3.15-rc5 (d6d211db37e75de2ddc3a4f979038c40df7cc79c))
     avail    rsrvd     high    freed                board              kconfig                  dtb
         .        .        .        . tegra114-dalmore-a04   multi_v7_defconfig     tegra114-dalmore
         .        .        .        . tegra114-dalmore-a04      tegra_defconfig     tegra114-dalmore
         .        .        .        .       tegra30-beaver   multi_v7_defconfig       tegra30-beaver
         .        .        .        .       tegra30-beaver      tegra_defconfig       tegra30-beaver
