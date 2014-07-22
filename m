From: pwalmsley@nvidia.com (Paul Walmsley)
Date: Mon, 21 Jul 2014 20:45:22 -0700
Subject: Tegra baseline test results for v3.16-rc6
Message-ID: <53CDDE52.90506@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here are some basic Tegra test results for Linux v3.16-rc6.
Logs and other details at:

     http://nvt.pwsan.com/pub/linux/testlogs/test_v3.16-rc6/20140721180104/


Test summary
------------

Build: zImage:
     Pass: ( 2/ 2): multi_v7_defconfig, tegra_defconfig

Boot to userspace: multi_v7_defconfig:
     Pass: ( 2/ 2): tegra114-dalmore-a04, tegra30-beaver

Boot to userspace: tegra_defconfig:
     Pass: ( 2/ 2): tegra114-dalmore-a04, tegra30-beaver


vmlinux object size
(delta in bytes from test_v3.16-rc5 (1795cd9b3a91d4b5473c97f491d63892442212ab)):
    text     data      bss    total  kernel
   +2289     +376        0    +2665  multi_v7_defconfig
   +2341     +408        0    +2749  tegra_defconfig


Boot-time memory difference
(delta in bytes from test_v3.16-rc5 (1795cd9b3a91d4b5473c97f491d63892442212ab))
     avail    rsrvd     high    freed                board              kconfig                  dtb
       -8k       8k        .        . tegra114-dalmore-a04   multi_v7_defconfig     tegra114-dalmore
         .        .        .        . tegra114-dalmore-a04      tegra_defconfig     tegra114-dalmore
       -8k       8k        .        .       tegra30-beaver   multi_v7_defconfig       tegra30-beaver
         .        .        .        .       tegra30-beaver      tegra_defconfig       tegra30-beaver
