From: pwalmsley@nvidia.com (Paul Walmsley)
Date: Mon, 24 Jun 2013 22:23:21 -0700
Subject: Tegra baseline test results for v3.10-rc7
Message-ID: <51C92949.8000902@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here are some basic Tegra test results for Linux v3.10-rc7.
Logs and other details at:

    http://www.pwsan.com/tegra/testlogs/test_v3.10-rc7/20130622134509/


Test summary
------------

Build: zImage:
    Pass: ( 1/ 1): tegra_defconfig

Boot to userspace:
    Pass: ( 2/ 2): tegra114-dalmore-headless, tegra30-beaver


vmlinux object size
(delta in bytes from test_v3.10-rc6 (7d132055814ef17a6c7b69f342244c410a5e000f)):
   text     data      bss    total  kernel
   +749      +16        0     +765  tegra_defconfig
