From: pwalmsley@nvidia.com (Paul Walmsley)
Date: Sat, 7 Dec 2013 00:39:23 -0800
Subject: Tegra baseline test results for v3.13-rc3
Message-ID: <52A2DEBB.1000105@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here are some basic Tegra test results for Linux v3.13-rc3.
Logs and other details at:

     http://nvt.pwsan.com/pub/linux/testlogs/test_v3.13-rc3/20131207002705/


Test summary
------------

Build: zImage:
     Pass: ( 2/ 2): multi_v7_defconfig, tegra_defconfig

Boot to userspace: multi_v7_defconfig:
     Pass: ( 2/ 2): tegra114-dalmore-headless, tegra30-beaver

Boot to userspace: tegra_defconfig:
     Pass: ( 2/ 2): tegra114-dalmore-headless, tegra30-beaver


vmlinux object size
(delta in bytes from test_v3.13-rc2 (dc1ccc48159d63eca5089e507c82c7d22ef60839)):
    text     data      bss    total  kernel
  +38076    +1320        0   +39396  multi_v7_defconfig
    +732       +8        0     +740  tegra_defconfig

  
Boot-time memory difference
(delta in bytes from test_v3.13-rc2 (dc1ccc48159d63eca5089e507c82c7d22ef60839))
     avail    rsrvd     high    freed                board              kconfig                  dtb
      -40k      40k        .        . tegra114-dalmore-hea   multi_v7_defconfig     tegra114-dalmore
         .        .        .        . tegra114-dalmore-hea      tegra_defconfig     tegra114-dalmore
      -40k      40k        .        .       tegra30-beaver   multi_v7_defconfig       tegra30-beaver
         .        .        .        .       tegra30-beaver      tegra_defconfig       tegra30-beaver
