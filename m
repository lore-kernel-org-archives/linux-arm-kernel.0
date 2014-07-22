From: pwalmsley@nvidia.com (Paul Walmsley)
Date: Mon, 21 Jul 2014 20:45:00 -0700
Subject: Tegra baseline test results for v3.16-rc5
Message-ID: <53CDDE3C.8010705@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here are some basic Tegra test results for Linux v3.16-rc5.
Logs and other details at:

     http://nvt.pwsan.com/pub/linux/testlogs/test_v3.16-rc5/20140713143106/


Test summary
------------

Build: zImage:
     Pass: ( 2/ 2): multi_v7_defconfig, tegra_defconfig

Boot to userspace: multi_v7_defconfig:
     Pass: ( 2/ 2): tegra114-dalmore-a04, tegra30-beaver

Boot to userspace: tegra_defconfig:
     Pass: ( 2/ 2): tegra114-dalmore-a04, tegra30-beaver



vmlinux object size
(delta in bytes from test_v3.16-rc4 (cd3de83f147601356395b57a8673e9c5ff1e59d1)):
    text     data      bss    total  kernel
   +5204     -160        0    +5044  multi_v7_defconfig
    +560       -8        0     +552  tegra_defconfig


Boot-time memory difference
(delta in bytes from test_v3.16-rc4 (cd3de83f147601356395b57a8673e9c5ff1e59d1))
     avail    rsrvd     high    freed                board              kconfig                  dtb
         .        .        .        . tegra114-dalmore-a04   multi_v7_defconfig     tegra114-dalmore
       -8k       8k        .        . tegra114-dalmore-a04      tegra_defconfig     tegra114-dalmore
         .        .        .        .       tegra30-beaver   multi_v7_defconfig       tegra30-beaver
       -8k       8k        .        .       tegra30-beaver      tegra_defconfig       tegra30-beaver
