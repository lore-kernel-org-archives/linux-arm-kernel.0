From: pwalmsley@nvidia.com (Paul Walmsley)
Date: Mon, 3 Mar 2014 14:27:23 -0800
Subject: Tegra baseline test results for v3.14-rc5
Message-ID: <531501CB.4010101@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here are some basic Tegra test results for Linux v3.14-rc5.
Logs and other details at:

     http://nvt.pwsan.com/pub/linux/testlogs/test_v3.14-rc5/20140302193106/


Test summary
------------

Build: zImage:
     Pass: ( 2/ 2): multi_v7_defconfig, tegra_defconfig

Boot to userspace: multi_v7_defconfig:
     Pass: ( 2/ 2): tegra114-dalmore-a04, tegra30-beaver

Boot to userspace: tegra_defconfig:
     Pass: ( 2/ 2): tegra114-dalmore-a04, tegra30-beaver


vmlinux object size
(delta in bytes from test_v3.14-rc4 (cfbf8d4857c26a8a307fb7cd258074c9dcd8c691)):
    text     data      bss    total  kernel
    +379      -16        0     +363  multi_v7_defconfig
    +387        0        0     +387  tegra_defconfig


Boot-time memory difference
(delta in bytes from test_v3.14-rc4 (cfbf8d4857c26a8a307fb7cd258074c9dcd8c691))
     avail    rsrvd     high    freed                board              kconfig                  dtb
         .        .        .        . tegra114-dalmore-a04   multi_v7_defconfig     tegra114-dalmore
         .        .        .        . tegra114-dalmore-a04      tegra_defconfig     tegra114-dalmore
         .        .        .        .       tegra30-beaver   multi_v7_defconfig       tegra30-beaver
         .        .        .        .       tegra30-beaver      tegra_defconfig       tegra30-beaver
