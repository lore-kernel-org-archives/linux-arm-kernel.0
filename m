From: shawn.guo@linaro.org (Shawn Guo)
Date: Sat, 5 Oct 2013 09:58:47 +0800
Subject: [PATCH 2/2] ARM i.MX53: dts: Add TVE to i.MX53-QSB device tree
In-Reply-To: <1380552008.3959.29.camel@pizza.hi.pengutronix.de>
References: <1380192374-9531-1-git-send-email-p.zabel@pengutronix.de>
 <1380192374-9531-2-git-send-email-p.zabel@pengutronix.de>
 <20130927011643.GB25146@S2101-09.ap.freescale.net>
 <1380552008.3959.29.camel@pizza.hi.pengutronix.de>
Message-ID: <20131005015845.GC2734@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 30, 2013 at 04:40:08PM +0200, Philipp Zabel wrote:
> > > @@ -280,8 +289,8 @@ memgpu: /memreserve/ 0xb0000000 0x04000000;
> > >  			};
> > >  
> > >  			ldo8_reg: ldo8 {
> > > -				regulator-min-microvolt = <1200000>;
> > > -				regulator-max-microvolt = <3600000>;
> > > +				regulator-min-microvolt = <2750000>;
> > > +				regulator-max-microvolt = <2750000>;
> > 
> > Why this change?
> 
> According to the reference manual, the TVDAC supply should be 2.75 V. If
> there are no ill effects if this ldo is actually set to 3.6 V, this
> change could be dropped.

So you either add a comment in commit log for the change or drop the
change.

Shawn
