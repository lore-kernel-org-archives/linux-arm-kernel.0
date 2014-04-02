From: pwalmsley@nvidia.com (Paul Walmsley)
Date: Wed, 2 Apr 2014 13:27:01 -0700
Subject: Tegra baseline test results for v3.14
Message-ID: <533C7295.9050806@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here are some basic Tegra test results for Linux v3.14.
Logs and other details at:

     http://nvt.pwsan.com/pub/linux/testlogs/test_v3.14/20140331183045/


Test summary
------------

Build: zImage:
     Pass: ( 2/ 2): multi_v7_defconfig, tegra_defconfig

Boot to userspace: multi_v7_defconfig:
     Pass: ( 2/ 2): tegra114-dalmore-a04, tegra30-beaver

Boot to userspace: tegra_defconfig:
     Pass: ( 2/ 2): tegra114-dalmore-a04, tegra30-beaver


vmlinux object size
(delta in bytes from test_v3.14-rc8 (b098d6726bbfb94c06d6e1097466187afddae61f)):
    text     data      bss    total  kernel
    +596     +136        0     +732  multi_v7_defconfig
   +1560      +64        0    +1624  tegra_defconfig


Boot-time memory difference
(delta in bytes from test_v3.14-rc8 (b098d6726bbfb94c06d6e1097466187afddae61f))
     avail    rsrvd     high    freed                board              kconfig                  dtb
         .        .        .        . tegra114-dalmore-a04   multi_v7_defconfig     tegra114-dalmore
         .        .        .        . tegra114-dalmore-a04      tegra_defconfig     tegra114-dalmore
         .        .        .        .       tegra30-beaver   multi_v7_defconfig       tegra30-beaver
         .        .        .        .       tegra30-beaver      tegra_defconfig       tegra30-beaver
