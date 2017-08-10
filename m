From: tony@atomide.com (Tony Lindgren)
Date: Thu, 10 Aug 2017 10:03:41 -0700
Subject: [PATCH v2] arm, am335x: add support for Moxa UC-8100-ME-T open
 platform
In-Reply-To: <20170810155246.pfaii3zb5jblluwy@rob-hp-laptop>
References: <20170802065757.1074-1-sz.lin@moxa.com>
 <20170810155246.pfaii3zb5jblluwy@rob-hp-laptop>
Message-ID: <20170810170341.GM8569@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Rob Herring <robh@kernel.org> [170810 08:53]:
> On Wed, Aug 02, 2017 at 02:57:57PM +0800, SZ Lin wrote:
> > Add support for Moxa UC-8100-ME-T open platform
...

> > +	vbat: fixedregulator at 0 {
> 
> Unit address without reg property is not valid (build with W=2). Perhaps 
> vbat-regulator instead.
...

> > +	/* Power supply provides a fixed 3.3V @3A */
> > +	vmmcsd_fixed: fixedregulator at 1 {
> 
> Ditto
> 
> With those fixed,
> 
> Acked-by: Rob Herring <robh@kernel.org>

I've fixed it up here and will apply into omap-for-v4.14/dt
thanks.

Tony
