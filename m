From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 26 Nov 2013 08:29:49 +0900
Subject: [PATCH] ARM: exynos_defconfig: increase CONFIG_NR_CPUS value to 8
In-Reply-To: <3699555.ZHO9r7FOJe@amdc1227>
References: <1511364.Pd4tSi34z7@amdc1032> <3699555.ZHO9r7FOJe@amdc1227>
Message-ID: <1ad401ceea36$3bcbf940$b363ebc0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tomasz Figa wrote:
> 
> Hi Bart,
> 
> On Thursday 21 of November 2013 13:06:06 Bartlomiej Zolnierkiewicz wrote:
> > Current CONFIG_NR_CPUS value (2) is too small for:
> > - EXYNOS4412 (4 cores)
> > - EXYNOS5440 (4 cores)
> > - EXYNOS5410 (8 cores)
> > - EXYNOS5420 (8 cores)
> >
> > Set CONFIG_NR_CPUS to 8 so it is correct for all currently
> > supported SoCs.
> >
> > Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> > Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > ---
> >  arch/arm/configs/exynos_defconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Definitely a change we want to have.
> 
> Reviewed-by: Tomasz Figa <t.figa@samsung.com>
> 
Applied and you can see this in my tree in a couple of days.

Thanks,
Kukjin
