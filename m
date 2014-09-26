From: andriy.shevchenko@linux.intel.com (Andy Shevchenko)
Date: Fri, 26 Sep 2014 17:22:37 +0300
Subject: [PATCH] SPI: spi-pxa2xx: SPI support for Intel Quark X1000
In-Reply-To: <20140926100832.GE27755@sirena.org.uk>
References: <1411752349-31490-1-git-send-email-alvin.chen@intel.com>
 <1411752349-31490-2-git-send-email-alvin.chen@intel.com>
 <20140926100832.GE27755@sirena.org.uk>
Message-ID: <1411741357.22717.4.camel@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2014-09-26 at 11:08 +0100, Mark Brown wrote:
> On Fri, Sep 26, 2014 at 10:25:49AM -0700, Weike Chen wrote:

[]

>   It might also be helpful for review to have two
> patches, one splitting things out into the functions and another adding
> the Quark support.

I also suggest to go this way.

> 
> > +/*  see Quark SPI data sheet for implementation rationale */
> > +static u32 quark_x1000_set_clk_regvals(u32 rate, u32 *dds, u32 *clk_div)
> > +{
> 
> Please document this in the driver - I don't know if this datasheet is
> public but even if it is it may not stay that way.

Datasheet is public.
I'm just wondering if we can use just a formula instead of table.

-- 
Andy Shevchenko <andriy.shevchenko@intel.com>
Intel Finland Oy
