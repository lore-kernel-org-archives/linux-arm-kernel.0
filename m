From: tony@atomide.com (Tony Lindgren)
Date: Wed, 14 Aug 2013 00:30:01 -0700
Subject: [PATCH 12/22] ARM: dts: Remove '0x's from OMAP2420 H4 DTS file
In-Reply-To: <20130813154425.GH15278@lee--X1>
References: <1374490361-25769-1-git-send-email-lee.jones@linaro.org>
 <1374490361-25769-12-git-send-email-lee.jones@linaro.org>
 <20130813154425.GH15278@lee--X1>
Message-ID: <20130814073000.GW7656@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Lee Jones <lee.jones@linaro.org> [130813 08:51]:
> Tony, Benoit,
> 
> Poke

Looks like Benoit's new email address is bcousson at baylibre.com.
Probably best for Benoit to pick these to avoid merge conflicts.

Regards,

Tony
 
> On Mon, 22 Jul 2013, Lee Jones wrote:
> 
> > Cc: Beno?t Cousson <b-cousson@ti.com>
> > Cc: Tony Lindgren <tony@atomide.com>
> > Cc: linux-omap at vger.kernel.org
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  arch/arm/boot/dts/omap2420-h4.dts | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/arm/boot/dts/omap2420-h4.dts b/arch/arm/boot/dts/omap2420-h4.dts
> > index 224c08f..34cdecb 100644
> > --- a/arch/arm/boot/dts/omap2420-h4.dts
> > +++ b/arch/arm/boot/dts/omap2420-h4.dts
> > @@ -50,15 +50,15 @@
> >  			label = "bootloader";
> >  			reg = <0 0x20000>;
> >  		};
> > -		partition at 0x20000 {
> > +		partition at 20000 {
> >  			label = "params";
> >  			reg = <0x20000 0x20000>;
> >  		};
> > -		partition at 0x40000 {
> > +		partition at 40000 {
> >  			label = "kernel";
> >  			reg = <0x40000 0x200000>;
> >  		};
> > -		partition at 0x240000 {
> > +		partition at 240000 {
> >  			label = "file-system";
> >  			reg = <0x240000 0x3dc0000>;
> >  		};
> 
> -- 
> Lee Jones
> Linaro ST-Ericsson Landing Team Lead
> Linaro.org ? Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog
