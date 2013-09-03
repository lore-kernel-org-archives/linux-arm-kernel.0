From: pwalmsley@nvidia.com (Paul Walmsley)
Date: Tue, 3 Sep 2013 16:34:19 -0700
Subject: Tegra baseline test results for v3.11
Message-ID: <522671FB.8060105@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here are some basic Tegra test results for Linux v3.11.
Logs and other details at:

     http://nvt.pwsan.com/pub/linux/testlogs/test_v3.11/20130903160336/


Test summary
------------

Build: zImage:
     Pass: ( 2/ 2): multi_v7_defconfig, tegra_defconfig

Boot to userspace: multi_v7_defconfig:
     Pass: ( 2/ 2): tegra114-dalmore-headless, tegra30-beaver

Boot to userspace: tegra_defconfig:
     Pass: ( 2/ 2): tegra114-dalmore-headless, tegra30-beaver


vmlinux object size
(delta in bytes from test_v3.11-rc7 (d8dfad3876e4386666b759da3c833d62fb8b2267)):
    text     data      bss    total  kernel
    +980      +72        0    +1052  multi_v7_defconfig
   +1217      +16        0    +1233  tegra_defconfig


Boot-time memory difference
(delta in bytes from test_v3.11-rc7 (d8dfad3876e4386666b759da3c833d62fb8b2267))
     avail    rsrvd     high    freed                board              kconfig                  dtb
       -8k       8k        .        . tegra114-dalmore-hea   multi_v7_defconfig     tegra114-dalmore
         .        .        .        . tegra114-dalmore-hea      tegra_defconfig     tegra114-dalmore
       -8k       8k        .        .       tegra30-beaver   multi_v7_defconfig       tegra30-beaver
         .        .        .        .       tegra30-beaver      tegra_defconfig       tegra30-beaver
