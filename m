From: pwalmsley@nvidia.com (Paul Walmsley)
Date: Tue, 28 Jan 2014 20:29:33 -0800
Subject: Tegra baseline test results for v3.13
Message-ID: <52E883AD.1000401@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here are some basic Tegra test results for Linux v3.13.
Logs and other details at:

     http://nvt.pwsan.com/pub/linux/testlogs/test_v3.13/20140119190136/


Test summary
------------

Build: zImage:
     Pass: ( 2/ 2): multi_v7_defconfig, tegra_defconfig

Boot to userspace: multi_v7_defconfig:
     Pass: ( 2/ 2): tegra114-dalmore-headless, tegra30-beaver

Boot to userspace: tegra_defconfig:
     Pass: ( 2/ 2): tegra114-dalmore-headless, tegra30-beaver


vmlinux object size
(delta in bytes from test_v3.13-rc8 (7e22e91102c6b9df7c4ae2168910e19d2bb14cd6)):
    text     data      bss    total  kernel
     +28      -24        0       +4  multi_v7_defconfig
    +380        0        0     +380  tegra_defconfig


Boot-time memory difference
(delta in bytes from test_v3.13-rc8 (7e22e91102c6b9df7c4ae2168910e19d2bb14cd6))
     avail    rsrvd     high    freed                board              kconfig                  dtb
         .        .        .        . tegra114-dalmore-hea   multi_v7_defconfig     tegra114-dalmore
         .        .        .        . tegra114-dalmore-hea      tegra_defconfig     tegra114-dalmore
         .        .        .        .       tegra30-beaver   multi_v7_defconfig       tegra30-beaver
         .        .        .        .       tegra30-beaver      tegra_defconfig       tegra30-beaver
