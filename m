From: pwalmsley@nvidia.com (Paul Walmsley)
Date: Mon, 29 Jul 2013 22:29:36 -0700
Subject: Tegra baseline test results for v3.11-rc2
Message-ID: <51F74F40.2080403@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here are some basic Tegra test results for Linux v3.11-rc2.
Logs and other details at:

     http://nvt.pwsan.com/pub/linux/testlogs/test_v3.11-rc2/20130729210232/


Test summary
------------

Build: zImage:
     Pass: ( 2/ 2): multi_v7_defconfig, tegra_defconfig

Boot to userspace: multi_v7_defconfig:
     Pass: ( 2/ 2): tegra114-dalmore-headless, tegra30-beaver

Boot to userspace: tegra_defconfig:
     Pass: ( 2/ 2): tegra114-dalmore-headless, tegra30-beaver


vmlinux object size
(delta in bytes from test_v3.11-rc1 (ad81f0545ef01ea651886dddac4bef6cec930092)):
    text     data      bss    total  kernel
    +872     +184        0    +1056  multi_v7_defconfig
    +674     +256        0     +930  tegra_defconfig


Boot-time memory difference
(delta in bytes from test_v3.11-rc1 (ad81f0545ef01ea651886dddac4bef6cec930092))
     avail    rsrvd     high    freed                board              kconfig                  dtb
         .        .        .        . tegra114-dalmore-hea     tegra114-dalmore   multi_v7_defconfig
         .        .        .        . tegra114-dalmore-hea     tegra114-dalmore      tegra_defconfig
         .        .        .        .       tegra30-beaver       tegra30-beaver   multi_v7_defconfig
         .        .        .        .       tegra30-beaver       tegra30-beaver      tegra_defconfig
