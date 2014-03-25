From: pwalmsley@nvidia.com (Paul Walmsley)
Date: Tue, 25 Mar 2014 15:44:06 -0700
Subject: Tegra baseline test results for v3.14-rc8
Message-ID: <533206B6.5030905@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here are some basic Tegra test results for Linux v3.14-rc8.
Logs and other details at:

     http://nvt.pwsan.com/pub/linux/testlogs/test_v3.14-rc8/20140324200103/


Test summary
------------

Build: zImage:
     Pass: ( 2/ 2): multi_v7_defconfig, tegra_defconfig

Boot to userspace: multi_v7_defconfig:
     Pass: ( 2/ 2): tegra114-dalmore-a04, tegra30-beaver

Boot to userspace: tegra_defconfig:
     Pass: ( 2/ 2): tegra114-dalmore-a04, tegra30-beaver


vmlinux object size
(delta in bytes from test_v3.14-rc7 (dcb99fd9b08cfe1afe426af4d8d3cbc429190f15)):
    text     data      bss    total  kernel
   +1080      -16        0    +1064  multi_v7_defconfig
   +1076      -16        0    +1060  tegra_defconfig



Boot-time memory difference
(delta in bytes from test_v3.14-rc7 (dcb99fd9b08cfe1afe426af4d8d3cbc429190f15))
     avail    rsrvd     high    freed                board              kconfig                  dtb
         .        .        .        . tegra114-dalmore-a04   multi_v7_defconfig     tegra114-dalmore
         .        .        .        . tegra114-dalmore-a04      tegra_defconfig     tegra114-dalmore
         .        .        .        .       tegra30-beaver   multi_v7_defconfig       tegra30-beaver
         .        .        .        .       tegra30-beaver      tegra_defconfig       tegra30-beaver
