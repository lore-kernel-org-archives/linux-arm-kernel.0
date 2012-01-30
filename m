From: w.sang@pengutronix.de (Wolfram Sang)
Date: Mon, 30 Jan 2012 14:41:30 +0100
Subject: [PATCH] mtd/gpmi : add BBT support
In-Reply-To: <201201301430.44374.marek.vasut@gmail.com>
References: <1327898174-13656-1-git-send-email-b32955@freescale.com>
 <201201301327.41298.marek.vasut@gmail.com>
 <20120130131205.GD15596@pengutronix.de>
 <201201301430.44374.marek.vasut@gmail.com>
Message-ID: <20120130134130.GG15596@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> Hehe, just torturing you guys a bit :)

And the gain of that is? The only outcome I currently see is that I feel
less motivated to put you on CC next time.

> > > > Did it always do that? Or is a newer version needed?
> > > 
> > > I can't comment on this one, I never used it. I rather got NAND working
> > > properly.
> > 
> > Me neither. But if so, we have another regression candidate.
> 
> What regression candidate ? The version of NAND driver in u-boot should be close 
> to what's in mainline Linux kernel.

I am not talking about U-Boot here. I was wondering if somebody who uses
the FSL deployment method would need to update kobs-ng, so a proper BBT
gets written. If so, people missing the need to update would see a
regression. Which is another reason to not make BBT usage default. But I
maybe wrong here. Huang will tell.

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120130/d8152c1a/attachment.sig>
