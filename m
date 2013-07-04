From: pwalmsley@nvidia.com (Paul Walmsley)
Date: Thu, 4 Jul 2013 14:18:58 -0700
Subject: Tegra baseline test results for v3.10
Message-ID: <51D5E6C2.60607@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here are some basic Tegra test results for Linux v3.10.
Logs and other details at:

     http://www.pwsan.com/tegra/testlogs/test_v3.10/20130701231549/


Test summary
------------

Build: zImage:
     Pass: ( 1/ 1): tegra_defconfig

Boot to userspace:
     Pass: ( 2/ 2): tegra114-dalmore-headless, tegra30-beaver



vmlinux object size
(delta in bytes from test_v3.10-rc6 (7d132055814ef17a6c7b69f342244c410a5e000f)):
    text     data      bss    total  kernel
   +1256       -8        0    +1248  tegra_defconfig
