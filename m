From: pwalmsley@nvidia.com (Paul Walmsley)
Date: Mon, 26 Aug 2013 13:58:46 -0700
Subject: Tegra baseline test results for v3.11-rc7
Message-ID: <521BC186.2070803@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here are some basic Tegra test results for Linux v3.11-rc7.
Logs and other details at:

     http://nvt.pwsan.com/pub/linux/testlogs/test_v3.11-rc7/20130825180108/


Test summary
------------

Build: zImage:
     Pass: ( 2/ 2): multi_v7_defconfig, tegra_defconfig

Boot to userspace: multi_v7_defconfig:
     Pass: ( 2/ 2): tegra114-dalmore-headless, tegra30-beaver

Boot to userspace: tegra_defconfig:
     Pass: ( 2/ 2): tegra114-dalmore-headless, tegra30-beaver


vmlinux object size
(delta in bytes from test_v3.11-rc6 (b36f4be3de1b123d8601de062e7dbfc904f305fb)):
    text     data      bss    total  kernel
    +816       -8        0     +808  multi_v7_defconfig
    +576       -8        0     +568  tegra_defconfig


Boot-time memory difference
(delta in bytes from test_v3.11-rc6 (b36f4be3de1b123d8601de062e7dbfc904f305fb))
     avail    rsrvd     high    freed                board              kconfig                  dtb
         .        .        .        . tegra114-dalmore-hea   multi_v7_defconfig     tegra114-dalmore
         .        .        .        . tegra114-dalmore-hea      tegra_defconfig     tegra114-dalmore
         .        .        .        .       tegra30-beaver   multi_v7_defconfig       tegra30-beaver
         .        .        .        .       tegra30-beaver      tegra_defconfig       tegra30-beaver
