From: pwalmsley@nvidia.com (Paul Walmsley)
Date: Mon, 26 Jan 2015 11:51:04 -0700
Subject: Tegra baseline test results for v3.19-rc6
Message-ID: <54C68C98.2060205@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here are some basic Tegra test results for Linux v3.19-rc6.
Logs and other details at:

     http://nvt.pwsan.com/pub/linux/testlogs/test_v3.19-rc6/20150125203104/


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
(delta in bytes from test_v3.19-rc5 (ec6f34e5b552fb0a52e6aae1a5afbbb1605cc6cc)):
    text     data      bss    total  kernel
   +1489    +2440        0    +3929  multi_v7_defconfig
   +1405      -16        0    +1389  tegra_defconfig



Boot-time memory difference
(delta in bytes from test_v3.19-rc5 (ec6f34e5b552fb0a52e6aae1a5afbbb1605cc6cc))
     avail    rsrvd     high    freed                board              kconfig                  dtb
         .        .        .        . tegra114-dalmore-a04   multi_v7_defconfig     tegra114-dalmore
         .        .        .        . tegra114-dalmore-a04      tegra_defconfig     tegra114-dalmore
         .        .        .        .  tegra124-jetson-tk1   multi_v7_defconfig  tegra124-jetson-tk1
         .        .        .        .  tegra124-jetson-tk1      tegra_defconfig  tegra124-jetson-tk1
         .        .        .        .       tegra30-beaver   multi_v7_defconfig       tegra30-beaver
         .        .        .        .       tegra30-beaver      tegra_defconfig       tegra30-beaver
