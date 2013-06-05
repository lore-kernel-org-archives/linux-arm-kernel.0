From: pwalmsley@nvidia.com (Paul Walmsley)
Date: Wed, 5 Jun 2013 06:13:21 +0000 (UTC)
Subject: Tegra baseline test results for v3.10-rc3
Message-ID: <alpine.DEB.2.02.1306050611570.13098@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Here are some basic Tegra test results for Linux v3.10-rc3.
Logs and other details at:

    http://www.pwsan.com/tegra/testlogs/test_v3.10-rc3/20130528120832/


Test summary
------------

Build: zImage:
    Pass ( 1/ 1): tegra_defconfig

Boot to userspace:
    Pass ( 1/ 1): t33beaver


vmlinux object size
(delta in bytes from test_v3.10-rc2 
(c7788792a5e7b0d5d7f96d0766b4cb6112d47d75)):
   text     data      bss    total  kernel
  +6357      -56        0    +6301  tegra_defconfig
