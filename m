From: p.pisati@gmail.com (Paolo Pisati)
Date: Thu, 3 Jul 2014 15:51:46 +0200
Subject: 3.16rc3 multiplatform, Armada 370 and IOMMU: unbootable kernel
Message-ID: <20140703135146.GA6898@luxor.wired.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I can't boot 3.16rc3 on my Globalscale Mirabox (Armada 370):

Linus 3.16rc3 tree, mvebu_v7_defconfig + another multiplatform soc
(e.g. omap3/4), enable IOMMU and the soc specific backend (IOMMU + OMAP_IOMMU)
and it gives a solid hang at boot - no output on console, so i can't debug
further.

The same multiplatform kernel, with support for a wide range of socs and iommu
(omap, exynos, imx, versatile, calxeda, tegra, etcetc), boots fine with
every other board, but hangs on armada: am i the only experiencing this?
is this a known issue?
-- 
bye,
p.
