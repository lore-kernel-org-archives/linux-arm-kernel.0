From: pwalmsley@nvidia.com (Paul Walmsley)
Date: Mon, 14 Oct 2013 12:38:01 -0700
Subject: Tegra baseline test results for v3.12-rc5
Message-ID: <525C4819.9030000@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here are some basic Tegra test results for Linux v3.12-rc5.
Logs and other details at:

     http://nvt.pwsan.com/pub/linux/testlogs/test_v3.12-rc5/20131014120118/


Test summary
------------

Build: zImage:
     Pass: ( 2/ 2): multi_v7_defconfig, tegra_defconfig

Boot to userspace: multi_v7_defconfig:
     Pass: ( 2/ 2): tegra114-dalmore-headless, tegra30-beaver

Boot to userspace: tegra_defconfig:
     Pass: ( 2/ 2): tegra114-dalmore-headless, tegra30-beaver


vmlinux object size
(delta in bytes from test_v3.12-rc4 (d0e639c9e06d44e713170031fe05fb60ebe680af)):
    text     data      bss    total  kernel
    +172        0        0     +172  multi_v7_defconfig
    +548       -8        0     +540  tegra_defconfig


Boot-time memory difference
(delta in bytes from test_v3.12-rc4 (d0e639c9e06d44e713170031fe05fb60ebe680af))
     avail    rsrvd     high    freed                board              kconfig                  dtb
         .        .        .        . tegra114-dalmore-hea   multi_v7_defconfig     tegra114-dalmore
         .        .        .        . tegra114-dalmore-hea      tegra_defconfig     tegra114-dalmore
         .        .        .        .       tegra30-beaver   multi_v7_defconfig       tegra30-beaver
         .        .        .        .       tegra30-beaver      tegra_defconfig       tegra30-beaver
