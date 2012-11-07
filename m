From: t.figa@samsung.com (Tomasz Figa)
Date: Wed, 07 Nov 2012 16:34:16 +0100
Subject: [PATCH] ARM: dts: exynos4: Add support for Exynos4x12 SoCs
In-Reply-To: <0c4501cdbc8f$5336add0$f9a40970$%kim@samsung.com>
References: <1351089359-7318-1-git-send-email-t.figa@samsung.com>
 <0c4501cdbc8f$5336add0$f9a40970$%kim@samsung.com>
Message-ID: <3301517.VQVR99BHPc@amdc1227>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kgene,

On Wednesday 07 of November 2012 11:26:42 Kukjin Kim wrote:
> Kukjin Kim wrote:
> > Tomasz Figa wrote:
> > > This patch adds device tree sources for Exynos4x12 SoC series
> > > (currently Exynos4212 and Exynos4412) and enables mach-exynos4-dt
> > > to support these SoCs.
> > > 
> > > Signed-off-by: Tomasz Figa <t.figa@samsung.com>
> > > Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> > > ---
> > > 
> > >  arch/arm/boot/dts/exynos4212.dtsi      | 28
> 
> ++++++++++++++++++++++++++++
> 
> > >  arch/arm/boot/dts/exynos4412.dtsi      | 28
> 
> ++++++++++++++++++++++++++++
> 
> > >  arch/arm/boot/dts/exynos4x12.dtsi      | 31
> > > 
> > > +++++++++++++++++++++++++++++++
> > > 
> > >  arch/arm/mach-exynos/mach-exynos4-dt.c |  2 ++
> > >  4 files changed, 89 insertions(+)
> > >  create mode 100644 arch/arm/boot/dts/exynos4212.dtsi
> > >  create mode 100644 arch/arm/boot/dts/exynos4412.dtsi
> > >  create mode 100644 arch/arm/boot/dts/exynos4x12.dtsi
> > 
> > Looks good to me, applied.
> 
> [...]
> 
> > +/include/ "exynos4x12-pinctrl.dtsi"
> 
> BTW, I think, above line should be added when exynos4x12-pinctrl patches
> applied.

Yes, you are right. Seems like a rebase error on my side. Can you fix it 
or should I send a fixed version?


Best regards,
-- 
Tomasz Figa
Samsung Poland R&D Center
SW Solution Development, Linux Platform
