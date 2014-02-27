From: pwalmsley@nvidia.com (Paul Walmsley)
Date: Thu, 27 Feb 2014 03:07:49 -0800
Subject: Tegra baseline test results for v3.14-rc3
Message-ID: <530F1C85.1060008@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here are some basic Tegra test results for Linux v3.14-rc3.
Logs and other details at:

     http://nvt.pwsan.com/pub/linux/testlogs/test_v3.14-rc3/20140227025305/


Test summary
------------

Build: zImage:
     Pass: ( 2/ 2): multi_v7_defconfig, tegra_defconfig

Boot to userspace: multi_v7_defconfig:
     Pass: ( 2/ 2): tegra114-dalmore-a04, tegra30-beaver

Boot to userspace: tegra_defconfig:
     Pass: ( 2/ 2): tegra114-dalmore-a04, tegra30-beaver



vmlinux object size
(delta in bytes from test_v3.14-rc2 (b28a960c42fcd9cfc987441fa6d1c1a471f0f9ed)):
    text     data      bss    total  kernel
  +10248   +30104        0   +40352  multi_v7_defconfig
   +9121     +264        0    +9385  tegra_defconfig



Boot-time memory difference
(delta in bytes from test_v3.14-rc2 (b28a960c42fcd9cfc987441fa6d1c1a471f0f9ed))
     avail    rsrvd     high    freed                board              kconfig                  dtb
      -36k      36k        .       4k tegra114-dalmore-a04   multi_v7_defconfig     tegra114-dalmore
       -8k       8k        .        . tegra114-dalmore-a04      tegra_defconfig     tegra114-dalmore
      -36k      36k        .       4k       tegra30-beaver   multi_v7_defconfig       tegra30-beaver
       -8k       8k        .        .       tegra30-beaver      tegra_defconfig       tegra30-beaver
