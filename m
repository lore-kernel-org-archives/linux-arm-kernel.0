From: mpa@pengutronix.de (Markus Pargmann)
Date: Wed, 12 Aug 2015 12:47:39 +0200
Subject: [PATCH 00/20] Regmap max_raw_io and bmc150 SPI support
In-Reply-To: <20150812103736.GR10748@sirena.org.uk>
References: <1439374365-20623-1-git-send-email-mpa@pengutronix.de>
 <20150812103736.GR10748@sirena.org.uk>
Message-ID: <20150812104739.GC19600@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 12, 2015 at 11:37:36AM +0100, Mark Brown wrote:
> On Wed, Aug 12, 2015 at 12:12:25PM +0200, Markus Pargmann wrote:
> > Hi,
> > 
> > this series was created to add SPI support to the bmc150 accelerometer driver.
> > To not add any regressions, I had to add some infrastructure that allows to use
> > regmap with busses that do limit the size of transfers (block smbus). I hope
> > this is sufficient to not break anything.
> 
> This is a really big series but looking at at least the initial patches
> there's a lot of unrelated cleanups mixed in with it.  Please don't do
> this, send things like cleanups separately so that your series is
> focused on the relevant topic.  This makes things much easier to work
> with.

Ok. I can try to separate them but there are lots of dependencies
between the patches and most of them touch regmap.c so I thought it may
be better to put it in one series.

I will try my best to separate them for the next version.

Best Regards,

Markus

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150812/22dbb89b/attachment.sig>
