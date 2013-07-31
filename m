From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 31 Jul 2013 11:21:00 +0100
Subject: [PATCH 01/22] ARM: ux500: Remove '0x's from HREF v60+ DTS file
In-Reply-To: <20130730115403.GA29992@amd.pavel.ucw.cz>
References: <1374242333-6852-1-git-send-email-lee.jones@linaro.org>
 <20130730115403.GA29992@amd.pavel.ucw.cz>
Message-ID: <20130731102100.GD13298@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 30 Jul 2013, Pavel Machek wrote:

> On Fri 2013-07-19 14:58:32, Lee Jones wrote:
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> 
> Why?

Convention.

> > diff --git a/arch/arm/boot/dts/hrefv60plus.dts b/arch/arm/boot/dts/hrefv60plus.dts
> > index 3d580d6..46fd8af 100644
> > --- a/arch/arm/boot/dts/hrefv60plus.dts
> > +++ b/arch/arm/boot/dts/hrefv60plus.dts
> > @@ -26,7 +26,7 @@
> >  
> >  	soc {
> >  		i2c at 80110000 {
> > -			bu21013_tp at 0x5c {
> > +			bu21013_tp at 5c {
> >  				reset-gpio = <&gpio4 15 0x4>;
> >  			};
> >  		};
> 

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
