From: pwalmsley@nvidia.com (Paul Walmsley)
Date: Mon, 13 Jan 2014 20:09:50 -0800
Subject: Tegra baseline test results for v3.13-rc8
Message-ID: <52D4B88E.8090109@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here are some basic Tegra test results for Linux v3.13-rc8.
Logs and other details at:

     http://nvt.pwsan.com/pub/linux/testlogs/test_v3.13-rc8/20140112023108/


Test summary
------------

Build: zImage:
     Pass: ( 2/ 2): multi_v7_defconfig, tegra_defconfig

Boot to userspace: multi_v7_defconfig:
     Pass: ( 2/ 2): tegra114-dalmore-headless, tegra30-beaver

Boot to userspace: tegra_defconfig:
     Pass: ( 2/ 2): tegra114-dalmore-headless, tegra30-beaver


vmlinux object size
(delta in bytes from test_v3.13-rc7 (d6e0a2dd12f4067a5bcefb8bbd8ddbeff800afbc)):
    text     data      bss    total  kernel
     +56        0        0      +56  multi_v7_defconfig
   +1373      -24        0    +1349  tegra_defconfig


Boot-time memory difference
(delta in bytes from test_v3.13-rc7 (d6e0a2dd12f4067a5bcefb8bbd8ddbeff800afbc))
     avail    rsrvd     high    freed                board              kconfig                  dtb
         .        .        .        . tegra114-dalmore-hea   multi_v7_defconfig     tegra114-dalmore
         .        .        .        . tegra114-dalmore-hea      tegra_defconfig     tegra114-dalmore
         .        .        .        .       tegra30-beaver   multi_v7_defconfig       tegra30-beaver
         .        .        .        .       tegra30-beaver      tegra_defconfig       tegra30-beaver


- Paul
