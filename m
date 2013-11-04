From: pwalmsley@nvidia.com (Paul Walmsley)
Date: Mon, 4 Nov 2013 12:46:27 -0800
Subject: Tegra baseline test results for v3.12
Message-ID: <527807A3.10108@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here are some basic Tegra test results for Linux v3.12.
Logs and other details at:

     http://nvt.pwsan.com/pub/linux/testlogs/test_v3.12/20131104103421/


Test summary
------------

Build: zImage:
     Pass: ( 2/ 2): multi_v7_defconfig, tegra_defconfig

Boot to userspace: multi_v7_defconfig:
     Pass: ( 2/ 2): tegra114-dalmore-headless, tegra30-beaver

Boot to userspace: tegra_defconfig:
     Pass: ( 2/ 2): tegra114-dalmore-headless, tegra30-beaver



vmlinux object size
(delta in bytes from test_v3.12-rc7 (test_v3.12-rc7)):
    text     data      bss    total  kernel
       0        0        0        0  multi_v7_defconfig
    -404        0        0     -404  tegra_defconfig



Boot-time memory difference
(delta in bytes from test_v3.12-rc7 (test_v3.12-rc7))
     avail    rsrvd     high    freed                board              kconfig                  dtb
         .        .        .        . tegra114-dalmore-hea   multi_v7_defconfig     tegra114-dalmore
         .        .        .        . tegra114-dalmore-hea      tegra_defconfig     tegra114-dalmore
         .        .        .        .       tegra30-beaver   multi_v7_defconfig       tegra30-beaver
         .        .        .        .       tegra30-beaver      tegra_defconfig       tegra30-beaver
