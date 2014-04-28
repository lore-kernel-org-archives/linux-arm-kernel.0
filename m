From: pwalmsley@nvidia.com (Paul Walmsley)
Date: Mon, 28 Apr 2014 15:23:22 -0700
Subject: Tegra baseline test results for v3.15-rc3
Message-ID: <535ED4DA.4080602@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here are some basic Tegra test results for Linux v3.15-rc3.
Logs and other details at:

     http://nvt.pwsan.com/pub/linux/testlogs/test_v3.15-rc3/20140427210106/


Test summary
------------

Build: zImage:
     Pass: ( 2/ 2): multi_v7_defconfig, tegra_defconfig

Boot to userspace: multi_v7_defconfig:
     Pass: ( 2/ 2): tegra114-dalmore-a04, tegra30-beaver

Boot to userspace: tegra_defconfig:
     Pass: ( 2/ 2): tegra114-dalmore-a04, tegra30-beaver



vmlinux object size
(delta in bytes from test_v3.15-rc2 (a798c10faf62a505d24e5f6213fbaf904a39623f)):
    text     data      bss    total  kernel
   +1184       -8        0    +1176  multi_v7_defconfig
    +752        0        0     +752  tegra_defconfig



Boot-time memory difference
(delta in bytes from test_v3.15-rc2 (a798c10faf62a505d24e5f6213fbaf904a39623f))
     avail    rsrvd     high    freed                board              kconfig                  dtb
         .        .        .        . tegra114-dalmore-a04   multi_v7_defconfig     tegra114-dalmore
       -8k       8k        .        . tegra114-dalmore-a04      tegra_defconfig     tegra114-dalmore
         .        .        .        .       tegra30-beaver   multi_v7_defconfig       tegra30-beaver
       -8k       8k        .        .       tegra30-beaver      tegra_defconfig       tegra30-beaver
