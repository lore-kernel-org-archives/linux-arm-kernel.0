From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 3 Jul 2014 16:27:59 +0200
Subject: 3.16rc3 multiplatform, Armada 370 and IOMMU: unbootable kernel
In-Reply-To: <20140703135146.GA6898@luxor.wired.org>
References: <20140703135146.GA6898@luxor.wired.org>
Message-ID: <20140703162759.3909592a@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Paolo Pisati,

On Thu, 3 Jul 2014 15:51:46 +0200, Paolo Pisati wrote:
> I can't boot 3.16rc3 on my Globalscale Mirabox (Armada 370):
> 
> Linus 3.16rc3 tree, mvebu_v7_defconfig + another multiplatform soc
> (e.g. omap3/4), enable IOMMU and the soc specific backend (IOMMU + OMAP_IOMMU)
> and it gives a solid hang at boot - no output on console, so i can't debug
> further.
> 
> The same multiplatform kernel, with support for a wide range of socs and iommu
> (omap, exynos, imx, versatile, calxeda, tegra, etcetc), boots fine with
> every other board, but hangs on armada: am i the only experiencing this?
> is this a known issue?

Thanks for reporting the issue. Just to make it easy to reproduce the
problem, could post the complete .config that exhibits the issue?

Thanks a lot!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
