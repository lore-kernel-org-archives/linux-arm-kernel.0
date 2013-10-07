From: pwalmsley@nvidia.com (Paul Walmsley)
Date: Mon, 7 Oct 2013 01:26:39 -0700
Subject: Tegra baseline test results for v3.12-rc4
Message-ID: <5252703F.40303@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here are some basic Tegra test results for Linux v3.12-rc4.
Logs and other details at:

     http://nvt.pwsan.com/pub/linux/testlogs/test_v3.12-rc4/20131007004737/


Test summary
------------

Build: zImage:
     Pass: ( 2/ 2): multi_v7_defconfig, tegra_defconfig

Boot to userspace: multi_v7_defconfig:
     Pass: ( 2/ 2): tegra114-dalmore-headless, tegra30-beaver

Boot to userspace: tegra_defconfig:
     Pass: ( 2/ 2): tegra114-dalmore-headless, tegra30-beaver


vmlinux object size
(delta in bytes from test_v3.12-rc3 (15c03dd4859ab16f9212238f29dd315654aa94f6)):
    text     data      bss    total  kernel
   +5384     +176        0    +5560  multi_v7_defconfig
   +5009       +8        0    +5017  tegra_defconfig


Boot-time memory difference
(delta in bytes from test_v3.12-rc3 (15c03dd4859ab16f9212238f29dd315654aa94f6))
     avail    rsrvd     high    freed                board              kconfig                  dtb
         .        .        .      -4k tegra114-dalmore-hea   multi_v7_defconfig     tegra114-dalmore
       -8k       8k        .        . tegra114-dalmore-hea      tegra_defconfig     tegra114-dalmore
         .        .        .      -4k       tegra30-beaver   multi_v7_defconfig       tegra30-beaver
       -8k       8k        .        .       tegra30-beaver      tegra_defconfig       tegra30-beaver
