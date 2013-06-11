From: pwalmsley@nvidia.com (Paul Walmsley)
Date: Tue, 11 Jun 2013 12:24:47 +0000 (UTC)
Subject: Tegra baseline test results for v3.10-rc5
Message-ID: <alpine.DEB.2.02.1306111220490.22645@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Here are some basic Tegra test results for Linux v3.10-rc5.
Logs and other details at:

    http://www.pwsan.com/tegra/testlogs/test_v3.10-rc5/20130611044210/


Test summary
------------

Build: zImage:
    Pass ( 1/ 1): tegra_defconfig

Boot to userspace:
    Pass ( 1/ 1): tegra30-beaver


vmlinux object size
(delta in bytes from test_v3.10-rc4 
(d683b96b072dc4680fc74964eca77e6a23d1fa6e)):
   text     data      bss    total  kernel
   +703       +8        0     +711  tegra_defconfig
