From: mpa@pengutronix.de (Markus Pargmann)
Date: Tue, 21 Jul 2015 12:10:37 +0200
Subject: [PATCH 0/9] gpiolib: Add GPIO name support
In-Reply-To: <20150721095457.GA9981@pengutronix.de>
References: <1437125570-28623-1-git-send-email-mpa@pengutronix.de>
 <CACRpkdY=SLGyrcvWT355b3Z+pBwb9gPzVcieD8mOn=zdyJ1mFw@mail.gmail.com>
 <CAAVeFuL5F=Y2boCWp_TZEAN-kdT-Ob9r-h1-eNVDjBHftFYkeg@mail.gmail.com>
 <20150721095457.GA9981@pengutronix.de>
Message-ID: <20150721101037.GB20023@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Jul 21, 2015 at 11:54:57AM +0200, Uwe Kleine-K?nig wrote:
> Hello,
> 
> On Tue, Jul 21, 2015 at 06:00:37PM +0900, Alexandre Courbot wrote:
> > On Sat, Jul 18, 2015 at 5:05 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
> > > I must say I like this series.
> I think apart from patch 3 which I'd like to have discussed a bit more,
> I like it, too. I didn't try, but the series should work fine without
> patch 3 such that this patch can be discussed separately and the
> remaining 8 patches can go in?

This series should work without patch 3, yes. Just remove the hogging
keyword from the gpios defined in the devicetree.
However some test coverage for this series would be good.

Best regards,

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150721/93f5e420/attachment.sig>
