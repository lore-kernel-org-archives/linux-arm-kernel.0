From: pwalmsley@nvidia.com (Paul Walmsley)
Date: Mon, 10 Mar 2014 15:26:07 -0700
Subject: Tegra baseline test results for v3.14-rc6
Message-ID: <531E3BFF.2020801@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here are some basic Tegra test results for Linux v3.14-rc6.
Logs and other details at:

     http://nvt.pwsan.com/experimental/linux/testlogs/test_v3.14-rc6/20140309213233/


Test summary
------------

Build: zImage:
     Pass: ( 9/ 9): tegra_defconfig%tegra20,114_mergeconfig,
		   tegra_defconfig%tegra30,114_mergeconfig,
		   tegra_defconfig%tegra30_mergeconfig,
		   tegra_defconfig%tegra20,30_mergeconfig,
		   tegra_defconfig%tegra124_mergeconfig,
		   tegra_defconfig%tegra114_mergeconfig,
		   multi_v7_defconfig,
		   tegra_defconfig%tegra20_mergeconfig, tegra_defconfig

Boot to userspace: multi_v7_defconfig:
     Pass: ( 2/ 2): tegra114-dalmore-a04, tegra30-beaver

Boot to userspace: tegra_defconfig:
     Pass: ( 2/ 2): tegra114-dalmore-a04, tegra30-beaver

Boot to userspace: tegra_defconfig%tegra114_mergeconfig:
     Pass: ( 1/ 1): tegra114-dalmore-a04

Boot to userspace: tegra_defconfig%tegra20,114_mergeconfig:
     Pass: ( 1/ 1): tegra114-dalmore-a04

Boot to userspace: tegra_defconfig%tegra20,30_mergeconfig:
     Pass: ( 1/ 1): tegra30-beaver

Boot to userspace: tegra_defconfig%tegra30,114_mergeconfig:
     Pass: ( 2/ 2): tegra114-dalmore-a04, tegra30-beaver

Boot to userspace: tegra_defconfig%tegra30_mergeconfig:
     Pass: ( 1/ 1): tegra30-beaver


vmlinux object size
(delta in bytes from test_v3.14-rc5 (0414855fdc4a40da05221fc6062cccbc0c30f169)):
    text     data      bss    total  kernel
   +1684     +280      -64    +1900  multi_v7_defconfig
  +21635    +1536      +64   +23235  tegra_defconfig


Boot-time memory difference
(delta in bytes from test_v3.14-rc5 (0414855fdc4a40da05221fc6062cccbc0c30f169))
   avail  rsrvd   high  freed  board          kconfig
(no differences)
