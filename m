From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Thu, 13 Nov 2014 10:26:02 +0530
Subject: [PATCH] ARM: EXYNOS: Remove unused static iomapping
In-Reply-To: <54641AF1.50105@samsung.com>
References: <1415683022-21771-1-git-send-email-pankaj.dubey@samsung.com>
 <54641AF1.50105@samsung.com>
Message-ID: <000e01cffefe$2ca2f8a0$85e8e9e0$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kukjin,

On Thursday, November 13, 2014 8:14 AM, Kukjin Kim wrote:
> Subject: Re: [PATCH] ARM: EXYNOS: Remove unused static iomapping
> 
> On 11/11/14 14:17, Pankaj Dubey wrote:
> > This patch removes all unused static iomapping from exynos4/5_iodesc
> > table, and at the same time removes related macros from map.h and
> > map-s5p.h.
> > All such mappings are present in exynos.c but not currently there are
> > no users of these mappings, so its safe to remove these.
> >
> > Signed-off-by: Pankaj Dubey<pankaj.dubey@samsung.com>
> > ---
> > This patch has been compiled tested for exynos_defconfig;
> > multi_v7_defconfig; s5pv210_defconfig; s3c6400_defconfig; and
> s3c2410_defconfig.
> >
> > I have verified system booting on SMDK5250 and Exynos3250 based board.
> >
> >   arch/arm/mach-exynos/exynos.c                |   50
--------------------------
> >   arch/arm/mach-exynos/include/mach/map.h      |   23 ------------
> >   arch/arm/plat-samsung/include/plat/map-s5p.h |   21 -----------
> >   3 files changed, 94 deletions(-)
> 
> Applied, thanks.
> 

May be I am missing something here, but I can't see this in any branch of
your tree.

Thanks,
Pankaj Dubey
> - Kukjin
