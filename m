From: pwalmsley@nvidia.com (Paul Walmsley)
Date: Wed, 5 Jun 2013 06:19:55 +0000 (UTC)
Subject: Tegra baseline test results for v3.10-rc4
Message-ID: <alpine.DEB.2.02.1306050618190.13098@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Here are some basic Tegra test results for Linux v3.10-rc4.
Logs and other details at:

    http://www.pwsan.com/tegra/testlogs/test_v3.10-rc4/20130603044655/


Test summary
------------

Build: zImage:
    Pass ( 1/ 1): tegra_defconfig

Boot to userspace:
    Pass ( 1/ 1): t33beaver


vmlinux object size
(delta in bytes from test_v3.10-rc3 
(e4aa937ec75df0eea0bee03bffa3303ad36c986b)):
   text     data      bss    total  kernel
   -480        0        0     -480  tegra_defconfig
