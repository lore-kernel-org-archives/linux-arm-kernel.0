From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 24 Jul 2013 16:05:00 +0100
Subject: [PATCH v2 07/22] ARM: Exynos4210: Remove '0x's from Exynos4110
 DTSI file
In-Reply-To: <6156493.tCYrm4xD5A@amdc1227>
References: <1374490361-25769-1-git-send-email-lee.jones@linaro.org>
 <1374490361-25769-7-git-send-email-lee.jones@linaro.org>
 <20130724123931.GL26801@laptop> <6156493.tCYrm4xD5A@amdc1227>
Message-ID: <20130724150500.GN26801@laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 24 Jul 2013, Tomasz Figa wrote:

> On Wednesday 24 of July 2013 13:39:31 Lee Jones wrote:
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
> Looks good to me, except the subject which is still wrong - 
> s/Exynos4110/Exynos4210/.

Ah, I get you know. My bad, will fix.

> I guess it might be fixed when applying, though.


-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
