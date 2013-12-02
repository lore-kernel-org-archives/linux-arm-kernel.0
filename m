From: pwalmsley@nvidia.com (Paul Walmsley)
Date: Mon, 2 Dec 2013 07:22:12 -0800
Subject: Tegra baseline test results for v3.13-rc2
Message-ID: <alpine.DEB.2.02.1312020719270.6972@tamien>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Here are some basic Tegra test results for Linux v3.13-rc2.
Logs and other details at:

     http://nvt.pwsan.com/pub/linux/testlogs/test_v3.13-rc2/20131129133107/


Test summary
------------

Build: zImage:
     Pass: ( 2/ 2): multi_v7_defconfig, tegra_defconfig

Boot to userspace: multi_v7_defconfig:
     Pass: ( 2/ 2): tegra114-dalmore-headless, tegra30-beaver

Boot to userspace: tegra_defconfig:
     Pass: ( 2/ 2): tegra114-dalmore-headless, tegra30-beaver


vmlinux object size
(delta in bytes from test_v3.13-rc1 
(6ce4eac1f600b34f2f7f58f9cd8f0503d79e42ae)):
    text     data      bss    total  kernel
    +536     +136        0     +672  multi_v7_defconfig
   +4360       -8        0    +4352  tegra_defconfig


Boot-time memory difference
(delta in bytes from test_v3.13-rc1 
(6ce4eac1f600b34f2f7f58f9cd8f0503d79e42ae))
     avail    rsrvd     high    freed                board              kconfig                  dtb
         .        .        .        . tegra114-dalmore-hea   multi_v7_defconfig     tegra114-dalmore
         .        .        .        . tegra114-dalmore-hea      tegra_defconfig     tegra114-dalmore
         .        .        .        .       tegra30-beaver   multi_v7_defconfig       tegra30-beaver
         .        .        .        .       tegra30-beaver      tegra_defconfig       tegra30-beaver
