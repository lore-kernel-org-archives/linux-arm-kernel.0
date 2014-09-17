From: pwalmsley@nvidia.com (Paul Walmsley)
Date: Wed, 17 Sep 2014 01:32:20 +0000 (UTC)
Subject: Tegra baseline test results for v3.17-rc3
Message-ID: <alpine.DEB.2.02.1409170128010.5860@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Here are some basic Tegra test results for Linux v3.17-rc3.
Logs and other details at:

    http://nvt.pwsan.com/pub/linux/testlogs/test_v3.17-rc3/20140916151848/


Test summary
------------

Build: zImage:
    Pass: ( 2/ 2): multi_v7_defconfig, tegra_defconfig

Boot to userspace: multi_v7_defconfig:
    Pass: ( 3/ 3): tegra114-dalmore-a04, tegra124-jetson-tk1,
		   tegra30-beaver

Boot to userspace: tegra_defconfig:
    Pass: ( 3/ 3): tegra114-dalmore-a04, tegra124-jetson-tk1,
		   tegra30-beaver


vmlinux object size
(delta in bytes from test_v3.17-rc2 
(52addcf9d6669fa439387610bc65c92fa0980cef)):
   text     data      bss    total  kernel
 -12101     -528        0   -12629  multi_v7_defconfig
  -4296      +56        0    -4240  tegra_defconfig

Boot-time memory difference
(delta in bytes from test_v3.17-rc2 
(52addcf9d6669fa439387610bc65c92fa0980cef))
    avail    rsrvd     high    freed                board              kconfig                  dtb
       8k      -8k        .        . tegra114-dalmore-a04   multi_v7_defconfig     tegra114-dalmore
       8k      -8k        .        . tegra114-dalmore-a04      tegra_defconfig     tegra114-dalmore
       8k      -8k        .        .  tegra124-jetson-tk1   multi_v7_defconfig  tegra124-jetson-tk1
       8k      -8k        .        .  tegra124-jetson-tk1      tegra_defconfig  tegra124-jetson-tk1
       8k      -8k        .        .       tegra30-beaver   multi_v7_defconfig       tegra30-beaver
       8k      -8k        .        .       tegra30-beaver      tegra_defconfig       tegra30-beaver
