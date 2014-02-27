From: pwalmsley@nvidia.com (Paul Walmsley)
Date: Thu, 27 Feb 2014 03:15:27 -0800
Subject: Tegra baseline test results for v3.14-rc4
Message-ID: <530F1E4F.8040800@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here are some basic Tegra test results for Linux v3.14-rc4.
Logs and other details at:

     http://nvt.pwsan.com/pub/linux/testlogs/test_v3.14-rc4/20140227030347/


Test summary
------------

Build: zImage:
     Pass: ( 2/ 2): multi_v7_defconfig, tegra_defconfig

Boot to userspace: multi_v7_defconfig:
     Pass: ( 2/ 2): tegra114-dalmore-a04, tegra30-beaver

Boot to userspace: tegra_defconfig:
     Pass: ( 2/ 2): tegra114-dalmore-a04, tegra30-beaver


vmlinux object size
(delta in bytes from test_v3.14-rc3 (6d0abeca3242a88cab8232e4acd7e2bf088f3bc2)):
    text     data      bss    total  kernel
   -2489     +280        0    -2209  multi_v7_defconfig
   -7385     +320        0    -7065  tegra_defconfig


Boot-time memory difference
(delta in bytes from test_v3.14-rc3 (6d0abeca3242a88cab8232e4acd7e2bf088f3bc2))
     avail    rsrvd     high    freed                board              kconfig                  dtb
         .        .        .        . tegra114-dalmore-a04   multi_v7_defconfig     tegra114-dalmore
        8k      -8k        .        . tegra114-dalmore-a04      tegra_defconfig     tegra114-dalmore
         .        .        .        .       tegra30-beaver   multi_v7_defconfig       tegra30-beaver
        8k      -8k        .        .       tegra30-beaver      tegra_defconfig       tegra30-beaver
