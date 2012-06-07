From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Thu, 07 Jun 2012 12:11:05 +0300
Subject: [PATCH v6] MTD: LPC32xx SLC NAND driver
In-Reply-To: <20120607081108.GO8262@n2100.arm.linux.org.uk>
References: <1338974414-5308-1-git-send-email-stigge@antcom.de>
 <1338989921.6875.50.camel@sauron.fi.intel.com>
 <20120607081108.GO8262@n2100.arm.linux.org.uk>
Message-ID: <1339060265.6875.91.camel@sauron.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2012-06-07 at 09:11 +0100, Russell King - ARM Linux wrote:
> On Wed, Jun 06, 2012 at 04:38:41PM +0300, Artem Bityutskiy wrote:
> > On Wed, 2012-06-06 at 11:20 +0200, Roland Stigge wrote:
> > > +#else
> > > +#define lpc32xx_nand_resume NULL
> > > +#define lpc32xx_nand_suspend NULL
> > > +#endif
> > 
> > 0, not NULL.
> 
> Err, what planet are you on there.  These are _pointers_ to functions,
> so using a _pointer_ is more correct than using an _integer_.

Yes, thanks, I was wrong. 

-- 
Best Regards,
Artem Bityutskiy
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120607/72ac7915/attachment.sig>
