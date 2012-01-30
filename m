From: w.sang@pengutronix.de (Wolfram Sang)
Date: Mon, 30 Jan 2012 14:12:05 +0100
Subject: [PATCH] mtd/gpmi : add BBT support
In-Reply-To: <201201301327.41298.marek.vasut@gmail.com>
References: <1327898174-13656-1-git-send-email-b32955@freescale.com>
 <4F267F21.1030204@freescale.com>
 <20120130114131.GC15596@pengutronix.de>
 <201201301327.41298.marek.vasut@gmail.com>
Message-ID: <20120130131205.GD15596@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > U-Boot has NAND support in mainline, for barebox it is work-in-progress.
> 
> Why don't you rather start hacking on u-boot instead of chasing behind it all 
> the time ;-)

"chasing all the time behind it" is plain wrong, you should know that. I
also fed back the DMA fix I found. Besides, this is off-topic.

> > Did it always do that? Or is a newer version needed?
> 
> I can't comment on this one, I never used it. I rather got NAND working 
> properly.

Me neither. But if so, we have another regression candidate.

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120130/c92e28fb/attachment.sig>
