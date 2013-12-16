From: pwalmsley@nvidia.com (Paul Walmsley)
Date: Mon, 16 Dec 2013 12:10:55 -0800
Subject: Tegra baseline test results for v3.13-rc4
Message-ID: <52AF5E4F.1000906@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here are some basic Tegra test results for Linux v3.13-rc4.
Logs and other details at:

     http://nvt.pwsan.com/pub/linux/testlogs/test_v3.13-rc4/20131215130135/


Test summary
------------

Build: zImage:
     Pass: ( 2/ 2): multi_v7_defconfig, tegra_defconfig

Boot to userspace: multi_v7_defconfig:
     Pass: ( 2/ 2): tegra114-dalmore-headless, tegra30-beaver

Boot to userspace: tegra_defconfig:
     Pass: ( 2/ 2): tegra114-dalmore-headless, tegra30-beaver


vmlinux object size
(delta in bytes from test_v3.13-rc3 (374b105797c3d4f29c685f3be535c35f5689b30e)):
    text     data      bss    total  kernel
   +2352     +256        0    +2608  multi_v7_defconfig
  -10722      +64        0   -10658  tegra_defconfig


Boot-time memory difference
(delta in bytes from test_v3.13-rc3 (374b105797c3d4f29c685f3be535c35f5689b30e))
     avail    rsrvd     high    freed                board              kconfig                  dtb
         .        .        .        . tegra114-dalmore-hea   multi_v7_defconfig     tegra114-dalmore
        8k      -8k        .        . tegra114-dalmore-hea      tegra_defconfig     tegra114-dalmore
         .        .        .        .       tegra30-beaver   multi_v7_defconfig       tegra30-beaver
        8k      -8k        .        .       tegra30-beaver      tegra_defconfig       tegra30-beaver
