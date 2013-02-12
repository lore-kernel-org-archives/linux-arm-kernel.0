From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 12 Feb 2013 10:49:39 -0800
Subject: [PATCH] ARM: dts: exynos4x12-pinctrl: Correct pin configuration of
 SD 4
In-Reply-To: <2881673.R8geCWDSpT@amdc1227>
References: <1360578073-16207-1-git-send-email-s.shirish@samsung.com>
 <2881673.R8geCWDSpT@amdc1227>
Message-ID: <1d7401ce0951$b7cd9e70$2768db50$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tomasz Figa wrote:
> 
> On Monday 11 of February 2013 05:21:13 Shirish S wrote:
> > This patch corrects the pin function value of sd4_bus8 from 3
> > to 4.
> > This is verified on origen board for testing eMMC on
> > dw_mci controller.
> >
> > Signed-off-by: Shirish S <s.shirish@samsung.com>
> > Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
> > ---
> >  arch/arm/boot/dts/exynos4x12-pinctrl.dtsi | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/arm/boot/dts/exynos4x12-pinctrl.dtsi
> > b/arch/arm/boot/dts/exynos4x12-pinctrl.dtsi index 8e6115a..099cec7
> > 100644
> > --- a/arch/arm/boot/dts/exynos4x12-pinctrl.dtsi
> > +++ b/arch/arm/boot/dts/exynos4x12-pinctrl.dtsi
> > @@ -661,7 +661,7 @@
> >
> >  		sd4_bus8: sd4-bus-width8 {
> >  			samsung,pins = "gpk1-3", "gpk1-4", "gpk1-5", "gpk1-
> 6";
> > -			samsung,pin-function = <3>;
> > +			samsung,pin-function = <4>;
> >  			samsung,pin-pud = <4>;
> >  			samsung,pin-drv = <3>;
> >  		};
> 
> Reviewed-by: Tomasz Figa <t.figa@samsung.com>
> 
Applied into next/fixes-samsung for v3.9 because this is not a critical bug
fix.

BTW, I'd preferred to use 'ARM: dts: .... for exynos4x12-pinctrl' in subject
because if we use the title like "ARM: dts: exynos4x12-pinctrl: ...", the
main description should be moved back and head of subject is a bit long. So
sometimes we cannot understand the title in the e-mail box before
checking/opening the patch. See below. 

Shirish S   [PATCH] ARM: dts: exynos4x12-pinctrl: Correct pin...
Mon/2/11/2013 ...
Shirish S   [PATCH] ARM: dts: Correct pin configuration of SD...
Mon/2/11/2013 ...

Thanks.

- Kukjin
