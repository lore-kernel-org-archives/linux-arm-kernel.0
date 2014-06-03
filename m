From: pwalmsley@nvidia.com (Paul Walmsley)
Date: Mon, 2 Jun 2014 23:50:13 -0700
Subject: Tegra baseline test results for v3.15-rc8
Message-ID: <538D7025.9080403@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here are some basic Tegra test results for Linux v3.15-rc8.
Logs and other details at:

     http://nvt.pwsan.com/pub/linux/testlogs/test_v3.15-rc8/20140602180103/


Test summary
------------

Build: zImage:
     Pass: ( 2/ 2): multi_v7_defconfig, tegra_defconfig

Boot to userspace: multi_v7_defconfig:
     Pass: ( 2/ 2): tegra114-dalmore-a04, tegra30-beaver

Boot to userspace: tegra_defconfig:
     Pass: ( 2/ 2): tegra114-dalmore-a04, tegra30-beaver



vmlinux object size
(delta in bytes from test_v3.15-rc7 (c7208164e66f63e3ec1759b98087849286410741)):
    text     data      bss    total  kernel
   +1488      +80      -64    +1504  multi_v7_defconfig
   +1296      +56     -128    +1224  tegra_defconfig



Boot-time memory difference
(delta in bytes from test_v3.15-rc7 (c7208164e66f63e3ec1759b98087849286410741))
     avail    rsrvd     high    freed                board              kconfig                  dtb
         .        .        .        . tegra114-dalmore-a04   multi_v7_defconfig     tegra114-dalmore
         .        .        .        . tegra114-dalmore-a04      tegra_defconfig     tegra114-dalmore
         .        .        .        .       tegra30-beaver   multi_v7_defconfig       tegra30-beaver
         .        .        .        .       tegra30-beaver      tegra_defconfig       tegra30-beaver
