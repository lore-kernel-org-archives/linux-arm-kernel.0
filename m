From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 23 Jul 2013 09:55:52 +0100
Subject: [PATCH 07/22] ARM: exynos: Remove '0x's from Exynos4110 DTSI file
In-Reply-To: <2350088.9z671SCjFz@flatron>
References: <1374490361-25769-1-git-send-email-lee.jones@linaro.org>
 <1374490361-25769-7-git-send-email-lee.jones@linaro.org>
 <2350088.9z671SCjFz@flatron>
Message-ID: <20130723085552.GF26801@laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 22 Jul 2013, Tomasz Figa wrote:

> Hi Lee,
> 
> On Monday 22 of July 2013 11:52:26 Lee Jones wrote:
> > Cc: Kukjin Kim <kgene.kim@samsung.com>
> > Cc: linux-samsung-soc at vger.kernel.org
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  arch/arm/boot/dts/exynos4210.dtsi | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm/boot/dts/exynos4210.dtsi
> > b/arch/arm/boot/dts/exynos4210.dtsi index b7f358a..53e2527 100644
> > --- a/arch/arm/boot/dts/exynos4210.dtsi
> > +++ b/arch/arm/boot/dts/exynos4210.dtsi
> > @@ -72,7 +72,7 @@
> >  		};
> >  	};
> > 
> > -	clock: clock-controller at 0x10030000 {
> > +	clock: clock-controller at 10030000 {
> >  		compatible = "samsung,exynos4210-clock";
> >  		reg = <0x10030000 0x20000>;
> >  		#clock-cells = <1>;
> 
> This looks fine, but please fix commit message - it should be Exynos4210. 
> Also some explanation why this change is needed would be good, even if 
> it's obvious.

Hi Tomasz,

I'm happy to fixup the $SUBJECT line, but do we really have to enter
an explanation if it's obvious? Seems a little belt and braces.

Kind regards,
Lee

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
