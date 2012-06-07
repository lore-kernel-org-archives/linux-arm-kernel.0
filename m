From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 7 Jun 2012 09:11:08 +0100
Subject: [PATCH v6] MTD: LPC32xx SLC NAND driver
In-Reply-To: <1338989921.6875.50.camel@sauron.fi.intel.com>
References: <1338974414-5308-1-git-send-email-stigge@antcom.de>
 <1338989921.6875.50.camel@sauron.fi.intel.com>
Message-ID: <20120607081108.GO8262@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 06, 2012 at 04:38:41PM +0300, Artem Bityutskiy wrote:
> On Wed, 2012-06-06 at 11:20 +0200, Roland Stigge wrote:
> > +#else
> > +#define lpc32xx_nand_resume NULL
> > +#define lpc32xx_nand_suspend NULL
> > +#endif
> 
> 0, not NULL.

Err, what planet are you on there.  These are _pointers_ to functions,
so using a _pointer_ is more correct than using an _integer_.
