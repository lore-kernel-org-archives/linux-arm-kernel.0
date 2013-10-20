From: pwalmsley@nvidia.com (Paul Walmsley)
Date: Sat, 19 Oct 2013 23:41:52 -0700
Subject: Tegra baseline test results for v3.12-rc6
Message-ID: <52637B30.7000203@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Here are some basic Tegra test results for Linux v3.12-rc6.
Logs and other details at:

     http://nvt.pwsan.com/pub/linux/testlogs/test_v3.12-rc6/20131019232523/


Test summary
------------

Build: zImage:
     Pass: ( 2/ 2): multi_v7_defconfig, tegra_defconfig

Boot to userspace: multi_v7_defconfig:
     Pass: ( 2/ 2): tegra114-dalmore-headless, tegra30-beaver

Boot to userspace: tegra_defconfig:
     Pass: ( 2/ 2): tegra114-dalmore-headless, tegra30-beaver


vmlinux object size
(delta in bytes from test_v3.12-rc5 (61e6cfa80de5760bbe406f4e815b7739205754d2)):
    text     data      bss    total  kernel
    -168      +64     -768     -872  multi_v7_defconfig
   -1781       -8     -704    -2493  tegra_defconfig


Boot-time memory difference
(delta in bytes from test_v3.12-rc5 (61e6cfa80de5760bbe406f4e815b7739205754d2))
     avail    rsrvd     high    freed                board              kconfig                  dtb
         .        .        .        . tegra114-dalmore-hea   multi_v7_defconfig     tegra114-dalmore
        8k      -8k        .        . tegra114-dalmore-hea      tegra_defconfig     tegra114-dalmore
         .        .        .        .       tegra30-beaver   multi_v7_defconfig       tegra30-beaver
        8k      -8k        .        .       tegra30-beaver      tegra_defconfig       tegra30-beaver
