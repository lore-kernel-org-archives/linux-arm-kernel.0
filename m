From: marek.vasut@gmail.com (Marek Vasut)
Date: Mon, 30 Jan 2012 14:30:44 +0100
Subject: [PATCH] mtd/gpmi : add BBT support
In-Reply-To: <20120130131205.GD15596@pengutronix.de>
References: <1327898174-13656-1-git-send-email-b32955@freescale.com>
 <201201301327.41298.marek.vasut@gmail.com>
 <20120130131205.GD15596@pengutronix.de>
Message-ID: <201201301430.44374.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > > U-Boot has NAND support in mainline, for barebox it is
> > > work-in-progress.
> > 
> > Why don't you rather start hacking on u-boot instead of chasing behind it
> > all the time ;-)
> 
> "chasing all the time behind it" is plain wrong, you should know that. I
> also fed back the DMA fix I found. Besides, this is off-topic.

Hehe, just torturing you guys a bit :)
> 
> > > Did it always do that? Or is a newer version needed?
> > 
> > I can't comment on this one, I never used it. I rather got NAND working
> > properly.
> 
> Me neither. But if so, we have another regression candidate.

What regression candidate ? The version of NAND driver in u-boot should be close 
to what's in mainline Linux kernel.
