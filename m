From: pwalmsley@nvidia.com (Paul Walmsley)
Date: Mon, 21 Apr 2014 21:54:47 -0700
Subject: Tegra baseline test results for v3.15-rc2
Message-ID: <5355F617.8020108@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here are some basic Tegra test results for Linux v3.15-rc2.
Logs and other details at:

     http://nvt.pwsan.com/pub/linux/testlogs/test_v3.15-rc2/20140420113108/


Test summary
------------

Build: zImage:
     Pass: ( 2/ 2): multi_v7_defconfig, tegra_defconfig

Boot to userspace: multi_v7_defconfig:
     Pass: ( 2/ 2): tegra114-dalmore-a04, tegra30-beaver

Boot to userspace: tegra_defconfig:
     Pass: ( 2/ 2): tegra114-dalmore-a04, tegra30-beaver



vmlinux object size
(delta in bytes from test_v3.15-rc1 (c9eaa447e77efe77b7fa4c953bd62de8297fd6c5)):
    text     data      bss    total  kernel
    +713      +72        0     +785  multi_v7_defconfig
    +349      -16        0     +333  tegra_defconfig



Boot-time memory difference
(delta in bytes from test_v3.15-rc1 (c9eaa447e77efe77b7fa4c953bd62de8297fd6c5))
     avail    rsrvd     high    freed                board              kconfig                  dtb
       -4k       4k        .        . tegra114-dalmore-a04   multi_v7_defconfig     tegra114-dalmore
         .        .        .        . tegra114-dalmore-a04      tegra_defconfig     tegra114-dalmore
       -4k       4k        .        .       tegra30-beaver   multi_v7_defconfig       tegra30-beaver
         .        .        .        .       tegra30-beaver      tegra_defconfig       tegra30-beaver
