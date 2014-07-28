From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 28 Jul 2014 09:39:53 +0900
Subject: [PATCH 0/3] ARM: EXYNOS: Fix Exynos5410 boot
In-Reply-To: <53D4EFBB.6000404@suse.de>
References: <1406463725-4208-1-git-send-email-afaerber@suse.de>
 <53D4EFBB.6000404@suse.de>
Message-ID: <00c901cfa9fc$727b4e10$5771ea30$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Andreas F?rber wrote:
> 
> Am 27.07.2014 14:22, schrieb Andreas F?rber:
> > Hello,
> >
> > This mini-series unbreaks booting on 5410 based ODROID-XU.
> >
> > Since I do not have access to a TRM, the address is a guess based on
> > 5250 and 5410. Such a node was not present in the 3.14 downstream tree.
> 
> s/5410/5420/
> 
OK.

> >
> > Regards,
> > Andreas
> >
> > Andreas F?rber (3):
> >   Documentation: devicetree: Document exynos5410 PMU
> >   ARM: dts: exynos: Add PMU to Exynos5410
> >   ARM: EXYNOS: Add support for Exynos5410 PMU
> >
> >  Documentation/devicetree/bindings/arm/samsung/pmu.txt | 1 +
> >  arch/arm/boot/dts/exynos5410.dtsi                     | 5 +++++
> >  arch/arm/mach-exynos/exynos.c                         | 1 +
> >  3 files changed, 7 insertions(+)
> 
Andreas, thanks.

I'll apply this whole series.

- Kukjin
