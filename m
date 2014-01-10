From: pwalmsley@nvidia.com (Paul Walmsley)
Date: Fri, 10 Jan 2014 00:06:17 -0800
Subject: Tegra baseline test results for v3.13-rc7
Message-ID: <52CFA9F9.4090900@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here are some basic Tegra test results for Linux v3.13-rc7.
Logs and other details at:

     http://nvt.pwsan.com/pub/linux/testlogs/test_v3.13-rc7/20140104153107/


Test summary
------------

Build: zImage:
     Pass: ( 2/ 2): multi_v7_defconfig, tegra_defconfig

Boot to userspace: multi_v7_defconfig:
     Pass: ( 2/ 2): tegra114-dalmore-headless, tegra30-beaver

Boot to userspace: tegra_defconfig:
     Pass: ( 2/ 2): tegra114-dalmore-headless, tegra30-beaver


vmlinux object size
(delta in bytes from test_v3.13-rc6 (802eee95bde72fd0cd0f3a5b2098375a487d1eda)):
    text     data      bss    total  kernel
    +256       +8        0     +264  multi_v7_defconfig
    +216       +8        0     +224  tegra_defconfig


Boot-time memory difference
(delta in bytes from test_v3.13-rc6 (802eee95bde72fd0cd0f3a5b2098375a487d1eda))
     avail    rsrvd     high    freed                board              kconfig                  dtb
         .        .        .        . tegra114-dalmore-hea   multi_v7_defconfig     tegra114-dalmore
         .        .        .        . tegra114-dalmore-hea      tegra_defconfig     tegra114-dalmore
         .        .        .        .       tegra30-beaver   multi_v7_defconfig       tegra30-beaver
         .        .        .        .       tegra30-beaver      tegra_defconfig       tegra30-beaver
