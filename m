From: mpa@pengutronix.de (Markus Pargmann)
Date: Tue, 15 Sep 2015 10:50:05 +0200
Subject: [PATCH 2/3] gpiolib: gpiod_hog remove separate name argument
In-Reply-To: <20150907080818.GQ9999@pengutronix.de>
References: <1439979512-3894-1-git-send-email-mpa@pengutronix.de>
 <1439979512-3894-3-git-send-email-mpa@pengutronix.de>
 <20150907080818.GQ9999@pengutronix.de>
Message-ID: <20150915085005.GC1537@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Sep 07, 2015 at 10:08:18AM +0200, Uwe Kleine-K?nig wrote:
> On Wed, Aug 19, 2015 at 12:18:31PM +0200, Markus Pargmann wrote:
> > From: Markus Pargmann <mpa@devmp.org>
> > 
> > The gpio name is now stored in the gpio descriptor, so we can simply use
> 
> What is now? Does this introduce a dependency; maybe better reference a
> commit here?

Thanks. Yes this was refering to patch 3 of series
"gpiolib: Add GPIO name support",
patch "gpiolib: Use GPIO name from names array for gpio descriptor".

However I can only reference by name here. Will add it to the commit
message.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150915/74eb2c75/attachment.sig>
