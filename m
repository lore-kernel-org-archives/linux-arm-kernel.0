From: pwalmsley@nvidia.com (Paul Walmsley)
Date: Thu, 3 Oct 2013 23:27:57 -0700
Subject: Tegra baseline test results for v3.12-rc3
Message-ID: <524E5FED.4010009@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here are some basic Tegra test results for Linux v3.12-rc3.
Logs and other details at:

     http://nvt.pwsan.com/pub/linux/testlogs/test_v3.12-rc3/20130929153116/


Test summary
------------

Build: zImage:
     Pass: ( 2/ 2): multi_v7_defconfig, tegra_defconfig

Boot to userspace: multi_v7_defconfig:
     Pass: ( 2/ 2): tegra114-dalmore-headless, tegra30-beaver

Boot to userspace: tegra_defconfig:
     Pass: ( 2/ 2): tegra114-dalmore-headless, tegra30-beaver


vmlinux object size
(delta in bytes from test_v3.12-rc2 (4a10c2ac2f368583138b774ca41fac4207911983)):
    text     data      bss    total  kernel
    +788        0        0     +788  multi_v7_defconfig
    +744       +8        0     +752  tegra_defconfig


Boot-time memory difference
(delta in bytes from test_v3.12-rc2 (4a10c2ac2f368583138b774ca41fac4207911983))
     avail    rsrvd     high    freed                board              kconfig                  dtb
         .        .        .        . tegra114-dalmore-hea   multi_v7_defconfig     tegra114-dalmore
         .        .        .        . tegra114-dalmore-hea      tegra_defconfig     tegra114-dalmore
         .        .        .        .       tegra30-beaver   multi_v7_defconfig       tegra30-beaver
         .        .        .        .       tegra30-beaver      tegra_defconfig       tegra30-beaver
