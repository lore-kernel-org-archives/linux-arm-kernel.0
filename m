From: w.sang@pengutronix.de (Wolfram Sang)
Date: Tue, 9 Aug 2011 11:19:06 +0200
Subject: GPMI-NAND Status?
In-Reply-To: <4E3FA88E.4070804@freescale.com>
References: <20110805135133.GA26981@pengutronix.de>
	<4E3FA88E.4070804@freescale.com>
Message-ID: <20110809091906.GA1923@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> >
> >ecclayout needs to be used to show that OOB is fully in use [1]
> >===============================================================
> >
> >Needed to make it work for JFFS2 and to pass the mtd-testsuite. A driver only
> >working with UBIFS is surely not ready for mainline.
> >
> It seems just modifying the ecclayout of GPMI-NAND can not fix the problem.
> It should also change the code of JFFS2 and mtd.
> 
> Some one ever posted a patch about this:
> http://lists.infradead.org/pipermail/linux-mtd/2007-December/020047.html

This mail is about MLC. That's another issue. For SLC, ecclayout should
work, no?

Regards,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110809/c327d9b1/attachment.sig>
