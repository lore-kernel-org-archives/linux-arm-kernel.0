From: pwalmsley@nvidia.com (Paul Walmsley)
Date: Tue, 8 Jul 2014 21:49:42 -0700
Subject: Tegra baseline test results for v3.16-rc4
Message-ID: <53BCC9E6.1010201@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here are some basic Tegra test results for Linux v3.16-rc4.
Logs and other details at:

     http://nvt.pwsan.com/pub/linux/testlogs/test_v3.16-rc4/20140708212443/


Test summary
------------

Build: zImage:
     Pass: ( 2/ 2): multi_v7_defconfig, tegra_defconfig

Boot to userspace: multi_v7_defconfig:
     Pass: ( 2/ 2): tegra114-dalmore-a04, tegra30-beaver

Boot to userspace: tegra_defconfig:
     Pass: ( 2/ 2): tegra114-dalmore-a04, tegra30-beaver



vmlinux object size
(delta in bytes from test_v3.16-rc3 (4c834452aad01531db949414f94f817a86348d59)):
    text     data      bss    total  kernel
   +3228    +2456        0    +5684  multi_v7_defconfig
   +1088      +64        0    +1152  tegra_defconfig


Boot-time memory difference
(delta in bytes from test_v3.16-rc3 (4c834452aad01531db949414f94f817a86348d59))
     avail    rsrvd     high    freed                board              kconfig                  dtb
      -12k      12k        .        . tegra114-dalmore-a04   multi_v7_defconfig     tegra114-dalmore
         .        .        .        . tegra114-dalmore-a04      tegra_defconfig     tegra114-dalmore
      -12k      12k        .        .       tegra30-beaver   multi_v7_defconfig       tegra30-beaver
         .        .        .        .       tegra30-beaver      tegra_defconfig       tegra30-beaver
