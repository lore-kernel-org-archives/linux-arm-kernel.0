From: tony@atomide.com (Tony Lindgren)
Date: Mon, 9 Jul 2012 01:59:44 -0700
Subject: [PATCH] arm/dts: am33xx wdt node
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A93E9A2FE9@DBDE01.ent.ti.com>
References: <1341405037-16391-1-git-send-email-afzal@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9A2FE9@DBDE01.ent.ti.com>
Message-ID: <20120709085944.GC1122@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Mohammed, Afzal <afzal@ti.com> [120704 06:44]:
> + Grant and device tree, watchdog lists
> 
> On Wed, Jul 04, 2012 at 18:00:37, Mohammed, Afzal wrote:
> > Add am33xx wdt node.
> > 
> > Signed-off-by: Afzal Mohammed <afzal@ti.com>
> > ---
> > 
> > Hi,
> > 
> > This was tested on AM335X EVM. This depends on,
> > http://www.mail-archive.com/linux-omap at vger.kernel.org/msg69424.html

Thanks I'll apply this into omap devel-dt branch now that we have
an ack from Wim on the wdt changes.

Tony

> > Regards
> > Afzal
> > 
> > 
> >  arch/arm/boot/dts/am33xx.dtsi | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
> > index f46e353..08b2a5b 100644
> > --- a/arch/arm/boot/dts/am33xx.dtsi
> > +++ b/arch/arm/boot/dts/am33xx.dtsi
> > @@ -185,5 +185,10 @@
> >  			compatible = "ti,omap3-hsmmc";
> >  			ti,hwmods = "mmc3";
> >  		};
> > +
> > +		wdt2: wdt at 44e35000 {
> > +			compatible = "ti,omap3-wdt";
> > +			ti,hwmods = "wd_timer2";
> > +		};
> >  	};
> >  };
> > -- 
> > 1.7.11.1
> > 
> > 
> 
