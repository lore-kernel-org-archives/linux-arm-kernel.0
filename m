From: marek.vasut@gmail.com (Marek Vasut)
Date: Mon, 30 Jan 2012 15:33:28 +0100
Subject: [PATCH] mtd/gpmi : add BBT support
In-Reply-To: <20120130134130.GG15596@pengutronix.de>
References: <1327898174-13656-1-git-send-email-b32955@freescale.com>
 <201201301430.44374.marek.vasut@gmail.com>
 <20120130134130.GG15596@pengutronix.de>
Message-ID: <201201301533.28882.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > Hehe, just torturing you guys a bit :)
> 
> And the gain of that is? The only outcome I currently see is that I feel
> less motivated to put you on CC next time.
> 
> > > > > Did it always do that? Or is a newer version needed?
> > > > 
> > > > I can't comment on this one, I never used it. I rather got NAND
> > > > working properly.
> > > 
> > > Me neither. But if so, we have another regression candidate.
> > 
> > What regression candidate ? The version of NAND driver in u-boot should
> > be close to what's in mainline Linux kernel.
> 
> I am not talking about U-Boot here. I was wondering if somebody who uses
> the FSL deployment method would need to update kobs-ng, so a proper BBT
> gets written.

... if someone actually still uses kobs-ng.

> If so, people missing the need to update would see a
> regression. Which is another reason to not make BBT usage default. But I
> maybe wrong here. Huang will tell.

Yes, either him or Fabio. This is a good point actually.
