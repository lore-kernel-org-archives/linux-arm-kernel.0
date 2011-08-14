From: w.sang@pengutronix.de (Wolfram Sang)
Date: Sun, 14 Aug 2011 20:31:48 +0200
Subject: GPMI-NAND Status?
In-Reply-To: <20110814081139.GD17063@parrot.com>
References: <20110805135133.GA26981@pengutronix.de>
	<20110814081139.GD17063@parrot.com>
Message-ID: <20110814183148.GA22576@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > problem overwriting all-0xff data in NAND [2]
> > =============================================
> > 
> > Although it occured only when writing JFFS2 images so far, this is a generic
> > issue and needs to be fixed, right?
> > 
> > 
> (...)
> > [2] http://lists.infradead.org/pipermail/linux-mtd/2011-July/037104.html
> 
> As explained in the thread linked above, this issue should be fixed in your

Yup, Huang pointed me already to the part I got wrong.

Thanks.

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110814/a6e123d6/attachment.sig>
