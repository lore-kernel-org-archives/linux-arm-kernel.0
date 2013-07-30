From: pwalmsley@nvidia.com (Paul Walmsley)
Date: Mon, 29 Jul 2013 22:34:58 -0700
Subject: Tegra baseline test results for v3.11-rc3
Message-ID: <51F75082.6090308@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here are some basic Tegra test results for Linux v3.11-rc3.
Logs and other details at:

     http://nvt.pwsan.com/pub/linux/testlogs/test_v3.11-rc3/20130729212315/


Test summary
------------

Build: zImage:
     Pass: ( 2/ 2): multi_v7_defconfig, tegra_defconfig

Boot to userspace: multi_v7_defconfig:
     Pass: ( 2/ 2): tegra114-dalmore-headless, tegra30-beaver

Boot to userspace: tegra_defconfig:
     Pass: ( 2/ 2): tegra114-dalmore-headless, tegra30-beaver



vmlinux object size
(delta in bytes from test_v3.11-rc2 (3b2f64d00c46e1e4e9bd0bb9bb12619adac27a4b)):
    text     data      bss    total  kernel
  +33580     +928    +1152   +35660  multi_v7_defconfig
    +129      +64        0     +193  tegra_defconfig


Boot-time memory difference
(delta in bytes from test_v3.11-rc2 (3b2f64d00c46e1e4e9bd0bb9bb12619adac27a4b))
     avail    rsrvd     high    freed                board              kconfig                  dtb
      -40k      40k        .       4k tegra114-dalmore-hea     tegra114-dalmore   multi_v7_defconfig
         .        .        .        . tegra114-dalmore-hea     tegra114-dalmore      tegra_defconfig
      -40k      40k        .       4k       tegra30-beaver       tegra30-beaver   multi_v7_defconfig
         .        .        .        .       tegra30-beaver       tegra30-beaver      tegra_defconfig
