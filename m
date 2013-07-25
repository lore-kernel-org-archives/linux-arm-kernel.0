From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 25 Jul 2013 08:52:15 +0100
Subject: [PATCH v3 07/22] ARM: dts: Remove '0x's from Exynos4210 DTSI file
In-Reply-To: <5075798.2aqxtybhC8@amdc1227>
References: <1374490361-25769-1-git-send-email-lee.jones@linaro.org>
 <1374490361-25769-7-git-send-email-lee.jones@linaro.org>
 <20130724150937.GO26801@laptop> <5075798.2aqxtybhC8@amdc1227>
Message-ID: <20130725075215.GA3403@laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 24 Jul 2013, Tomasz Figa wrote:

> On Wednesday 24 of July 2013 16:09:37 Lee Jones wrote:
> > ... for the sake of consistency and assumed convention.
> > 
> > Cc: Kukjin Kim <kgene.kim@samsung.com>
> > Cc: linux-samsung-soc at vger.kernel.org
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > 
> > diff --git a/arch/arm/boot/dts/exynos4210.dtsi
> > b/arch/arm/boot/dts/exynos4210.dtsi index b7f358a..53e2527 100644
> > --- a/arch/arm/boot/dts/exynos4210.dtsi
> > +++ b/arch/arm/boot/dts/exynos4210.dtsi
> > @@ -72,7 +72,7 @@
> >                 };
> >         };
> > 
> > -       clock: clock-controller at 0x10030000 {
> > +       clock: clock-controller at 10030000 {
> >                 compatible = "samsung,exynos4210-clock";
> >                 reg = <0x10030000 0x20000>;
> >                 #clock-cells = <1>;
> 
> Acked-by: Tomasz Figa <t.figa@samsung.com>

Thanks Tomasz.

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
