From: hvaibhav@ti.com (Hiremath, Vaibhav)
Date: Mon, 1 Apr 2013 11:20:04 +0000
Subject: Query regarding clk framework - from .set_rate api
References: <79CD15C6BA57404B839C016229A409A83EC3E7C3@DBDE01.ent.ti.com>
 <51596501.1020904@ti.com>
Message-ID: <79CD15C6BA57404B839C016229A409A83EC3E84A@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> -----Original Message-----
> From: Hiremath, Vaibhav
> Sent: Monday, April 01, 2013 4:37 PM
> To: Nayak, Rajendra
> Cc: mturquette at linaro.org; Paul Walmsley; Tony Lindgren; linux-
> omap at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> khilman at deeprootsystems.com
> Subject: RE: Query regarding clk framework - from .set_rate api
> 
> > -----Original Message-----
> > From: Nayak, Rajendra
> > Sent: Monday, April 01, 2013 4:14 PM
> > To: Hiremath, Vaibhav
> > Cc: mturquette at linaro.org; Paul Walmsley; Tony Lindgren; linux-
> > omap at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> > khilman at deeprootsystems.com
> > Subject: Re: Query regarding clk framework - from .set_rate api
> >
> > >
> > > Where, the clk_set_rate() seems to be not working, and that's true
> > > with the current implementation of OMAP/AM33xx clock tree,
> > > as the CLK_SET_RATE_PARENT flag is not set to any of the clock
> nodes.
> > >
> > > Please note that I am using DEFINE_STRUCT_CLK() macro for defining
> > clocks
> > > And which doesn't allow you to specify the flags.
> >
> > Use DEFINE_STRUCT_CLK_FLAGS() then. Its already used in AM33xx clock
> > tree.
> 
> Its not there in my kernel baseline v3.8.5, that?s why I missed it.
> It got merged into v3.9-rc.
> 
> I am testing it now, and will update shortly.
> 

And it works fine...

Sorry for the noise, I should have checked mainline status
before drafting this email.

Thanks,
Vaibhav
