From: pwalmsley@nvidia.com (Paul Walmsley)
Date: Mon, 28 Jul 2014 11:35:49 -0700
Subject: Tegra baseline test results for v3.16-rc7
Message-ID: <53D69805.3040508@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here are some basic Tegra test results for Linux v3.16-rc7.
Logs and other details at:

     http://nvt.pwsan.com/pub/linux/testlogs/test_v3.16-rc7/20140727130104/


Test summary
------------

Build: zImage:
     Pass: ( 2/ 2): multi_v7_defconfig, tegra_defconfig

Boot to userspace: multi_v7_defconfig:
     Pass: ( 2/ 2): tegra114-dalmore-a04, tegra30-beaver

Boot to userspace: tegra_defconfig:
     Pass: ( 2/ 2): tegra114-dalmore-a04, tegra30-beaver



vmlinux object size
(delta in bytes from test_v3.16-rc6 (9a3c4145af32125c5ee39c0272662b47307a8323)):
    text     data      bss    total  kernel
    +128       -8        0     +120  multi_v7_defconfig
     -28      -24        0      -52  tegra_defconfig


Boot-time memory difference
(delta in bytes from test_v3.16-rc6 (9a3c4145af32125c5ee39c0272662b47307a8323))
     avail    rsrvd     high    freed                board              kconfig                  dtb
         .        .        .        . tegra114-dalmore-a04   multi_v7_defconfig     tegra114-dalmore
         .        .        .        . tegra114-dalmore-a04      tegra_defconfig     tegra114-dalmore
         .        .        .        .       tegra30-beaver   multi_v7_defconfig       tegra30-beaver
         .        .        .        .       tegra30-beaver      tegra_defconfig       tegra30-beaver
