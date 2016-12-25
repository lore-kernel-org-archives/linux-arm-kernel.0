From: pavel@ucw.cz (Pavel Machek)
Date: Sun, 25 Dec 2016 22:20:38 +0100
Subject: [PATCH 1/4] serial: core: Add LED trigger support
In-Reply-To: <20161124081748.fx3xm5ww64ngn5it@pengutronix.de>
References: <20161123100106.15969-1-s.hauer@pengutronix.de>
 <20161123100106.15969-2-s.hauer@pengutronix.de>
 <e9fc12b8-d4a7-067d-ef87-03f0aae39bd7@gmail.com>
 <20161124081748.fx3xm5ww64ngn5it@pengutronix.de>
Message-ID: <20161225212038.GD26891@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > Could we somehow remedy the lack of knowledge from the core as whether
> > the HW sends/receives characters first before adding support for LED
> > triggers? It would be more generic and future proof to require UART
> > drivers to report to the core when they actually TX/RX, and then at the
> > core level, utilize that knowledge to perform the LED trigger.
> 
> Maybe we could introduce a function to read from the TX FIFO. Having
> open coded this in each and every driver is not nice anyway.

Yes, please.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161225/eb628365/attachment.sig>
