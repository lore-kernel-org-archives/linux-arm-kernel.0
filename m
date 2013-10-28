From: pwalmsley@nvidia.com (Paul Walmsley)
Date: Mon, 28 Oct 2013 15:40:06 -0700
Subject: Tegra baseline test results for v3.12-rc7
Message-ID: <526EE7C6.60208@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here are some basic Tegra test results for Linux v3.12-rc7.
Logs and other details at:

     http://nvt.pwsan.com/pub/linux/testlogs/test_v3.12-rc7/20131027163109/


Test summary
------------

Build: zImage:
     Pass: ( 2/ 2): multi_v7_defconfig, tegra_defconfig

Boot to userspace: multi_v7_defconfig:
     Pass: ( 2/ 2): tegra114-dalmore-headless, tegra30-beaver

Boot to userspace: tegra_defconfig:
     Pass: ( 2/ 2): tegra114-dalmore-headless, tegra30-beaver



vmlinux object size
(delta in bytes from test_v3.12-rc6 (31d141e3a666269a3b6fcccddb0351caf7454240)):
    text     data      bss    total  kernel
  +89324   -10192    +1184   +80316  multi_v7_defconfig
   +1380      +64        0    +1444  tegra_defconfig


Boot-time memory difference
(delta in bytes from test_v3.12-rc6 (31d141e3a666269a3b6fcccddb0351caf7454240))
     avail    rsrvd     high    freed                board              kconfig                  dtb
      -60k      60k        .       4k tegra114-dalmore-hea   multi_v7_defconfig     tegra114-dalmore
       12k     -12k        .        . tegra114-dalmore-hea      tegra_defconfig     tegra114-dalmore
      -72k      72k        .       4k       tegra30-beaver   multi_v7_defconfig       tegra30-beaver
         .        .        .        .       tegra30-beaver      tegra_defconfig       tegra30-beaver
