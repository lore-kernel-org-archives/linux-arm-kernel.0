From: joro@8bytes.org ('Joerg Roedel')
Date: Thu, 10 Jan 2013 18:19:05 +0100
Subject: [PATCH v6 00/12] iommu/exynos: Fixes and Enhancements of System
 MMU driver with DT
In-Reply-To: <032401cde783$485ae1a0$d910a4e0$@samsung.com>
References: <003301cde30b$c584c2d0$508e4870$%cho@samsung.com>
 <032401cde783$485ae1a0$d910a4e0$@samsung.com>
Message-ID: <20130110171844.GA2650@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 31, 2012 at 10:18:46AM -0800, Kukjin Kim wrote:
> Cho KyongHo wrote:

> > Diffstats:
> >  arch/arm/boot/dts/exynos5250-smdk5250.dts  |    2 +-
> >  arch/arm/boot/dts/exynos5250.dtsi          |   27 +-
> >  arch/arm/mach-exynos/Kconfig               |    5 -
> >  arch/arm/mach-exynos/Makefile              |    1 -
> >  arch/arm/mach-exynos/clock-exynos4.c       |   41 +-
> >  arch/arm/mach-exynos/clock-exynos4210.c    |    9 +-
> >  arch/arm/mach-exynos/clock-exynos4212.c    |   23 +-
> >  arch/arm/mach-exynos/clock-exynos5.c       |   87 +-
> >  arch/arm/mach-exynos/dev-sysmmu.c          |  274 ------
> >  arch/arm/mach-exynos/include/mach/sysmmu.h |   66 --
> >  arch/arm/mach-exynos/mach-exynos4-dt.c     |   34 +
> >  arch/arm/mach-exynos/mach-exynos5-dt.c     |   30 +
> >  drivers/iommu/Kconfig                      |    2 +-
> >  drivers/iommu/Makefile                     |    2 +-
> >  drivers/iommu/exynos-iommu.c               | 1477 +++++++++++++++++++++--
> > -----
> >  15 files changed, 1284 insertions(+), 796 deletions(-)
> 
> Joerg, it's time to merge this. If you don't mind, let me pick up this whole
> series into Samsung tree because this touches many Samsung stuff.

Well, looking at the diffstat the IOMMU changes are a lot larger than
the exynos ones. So I think this should go through the IOMMU tree once
the latest review comments are fixed.

> Happy new year, thanks.

Happy new year too,

      Joerg
