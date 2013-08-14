From: pwalmsley@nvidia.com (Paul Walmsley)
Date: Wed, 14 Aug 2013 10:24:21 -0700
Subject: Tegra baseline test results for v3.11-rc5
Message-ID: <520BBD45.7090708@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here are some basic Tegra test results for Linux v3.11-rc5.
Logs and other details at:

     http://nvt.pwsan.com/pub/linux/testlogs/test_v3.11-rc5/20130811183105/


Test summary
------------

Build: zImage:
     Pass: ( 2/ 2): multi_v7_defconfig, tegra_defconfig

Boot to userspace: multi_v7_defconfig:
     Pass: ( 2/ 2): tegra114-dalmore-headless, tegra30-beaver

Boot to userspace: tegra_defconfig:
     Pass: ( 2/ 2): tegra114-dalmore-headless, tegra30-beaver


vmlinux object size
(delta in bytes from test_v3.11-rc4 (c095ba7224d8edc71dcef0d655911399a8bd4a3f)):
    text     data      bss    total  kernel
    +628       +8        0     +636  multi_v7_defconfig
    +588       -8        0     +580  tegra_defconfig


Boot-time memory difference
(delta in bytes from test_v3.11-rc4 (c095ba7224d8edc71dcef0d655911399a8bd4a3f))
     avail    rsrvd     high    freed                board              kconfig                  dtb
         .        .        .        . tegra114-dalmore-hea   multi_v7_defconfig     tegra114-dalmore
         .        .        .        . tegra114-dalmore-hea      tegra_defconfig     tegra114-dalmore
         .        .        .        .       tegra30-beaver   multi_v7_defconfig       tegra30-beaver
         .        .        .        .       tegra30-beaver      tegra_defconfig       tegra30-beaver
