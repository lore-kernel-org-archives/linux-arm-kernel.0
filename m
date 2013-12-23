From: pwalmsley@nvidia.com (Paul Walmsley)
Date: Mon, 23 Dec 2013 13:30:26 -0800
Subject: Tegra baseline test results for v3.13-rc5
Message-ID: <52B8AB72.1080306@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here are some basic Tegra test results for Linux v3.13-rc5.
Logs and other details at:

     http://nvt.pwsan.com/pub/linux/testlogs/test_v3.13-rc5/20131223131320/


Test summary
------------

Build: zImage:
     Pass: ( 2/ 2): multi_v7_defconfig, tegra_defconfig

Boot to userspace: multi_v7_defconfig:
     Pass: ( 2/ 2): tegra114-dalmore-headless, tegra30-beaver

Boot to userspace: tegra_defconfig:
     Pass: ( 2/ 2): tegra114-dalmore-headless, tegra30-beaver


vmlinux object size
(delta in bytes from test_v3.13-rc4 (319e2e3f63c348a9b66db4667efa73178e18b17d)):
    text     data      bss    total  kernel
    +548     +192        0     +740  multi_v7_defconfig
   +4528        0        0    +4528  tegra_defconfig



Boot-time memory difference
(delta in bytes from test_v3.13-rc4 (319e2e3f63c348a9b66db4667efa73178e18b17d))
     avail    rsrvd     high    freed                board              kconfig                  dtb
         .        .        .        . tegra114-dalmore-hea   multi_v7_defconfig     tegra114-dalmore
       -8k       8k        .        . tegra114-dalmore-hea      tegra_defconfig     tegra114-dalmore
         .        .        .        .       tegra30-beaver   multi_v7_defconfig       tegra30-beaver
       -8k       8k        .        .       tegra30-beaver      tegra_defconfig       tegra30-beaver
