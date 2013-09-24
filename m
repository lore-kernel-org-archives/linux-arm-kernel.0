From: pwalmsley@nvidia.com (Paul Walmsley)
Date: Mon, 23 Sep 2013 18:08:42 -0700
Subject: Tegra baseline test results for v3.12-rc2
Message-ID: <5240E61A.9000204@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here are some basic Tegra test results for Linux v3.12-rc2.
Logs and other details at:

     http://nvt.pwsan.com/pub/linux/testlogs/test_v3.12-rc2/20130923160110/


Test summary
------------

Build: zImage:
     Pass: ( 2/ 2): multi_v7_defconfig, tegra_defconfig

Boot to userspace: multi_v7_defconfig:
     Pass: ( 2/ 2): tegra114-dalmore-headless, tegra30-beaver

Boot to userspace: tegra_defconfig:
     Pass: ( 2/ 2): tegra114-dalmore-headless, tegra30-beaver



vmlinux object size
(delta in bytes from test_v3.12-rc1 (272b98c6455f00884f0350f775c5342358ebb73f)):
    text     data      bss    total  kernel
    +388       +8        0     +396  multi_v7_defconfig
    +384        0        0     +384  tegra_defconfig



Boot-time memory difference
(delta in bytes from test_v3.12-rc1 (272b98c6455f00884f0350f775c5342358ebb73f))
     avail    rsrvd     high    freed                board              kconfig                  dtb
         .        .        .        . tegra114-dalmore-hea   multi_v7_defconfig     tegra114-dalmore
         .        .        .        . tegra114-dalmore-hea      tegra_defconfig     tegra114-dalmore
         .        .        .        .       tegra30-beaver   multi_v7_defconfig       tegra30-beaver
         .        .        .        .       tegra30-beaver      tegra_defconfig       tegra30-beaver
