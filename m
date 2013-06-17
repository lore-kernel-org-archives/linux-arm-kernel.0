From: pwalmsley@nvidia.com (Paul Walmsley)
Date: Mon, 17 Jun 2013 20:37:14 +0000 (UTC)
Subject: Tegra baseline test results for v3.10-rc6
Message-ID: <alpine.DEB.2.02.1306172036110.17176@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Here are some basic Tegra test results for Linux v3.10-rc6.
Logs and other details at:

    http://www.pwsan.com/tegra/testlogs/test_v3.10-rc6/20130617123049/


Test summary
------------

Build: zImage:
    Pass ( 1/ 1): tegra_defconfig

Boot to userspace:
    Pass ( 1/ 1): tegra30-beaver


vmlinux object size
(delta in bytes from test_v3.10-rc5 
(317ddd256b9c24b0d78fa8018f80f1e495481a10)):
   text     data      bss    total  kernel
  +1813        0        0    +1813  tegra_defconfig
