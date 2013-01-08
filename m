From: marex@denx.de (Marek Vasut)
Date: Tue, 8 Jan 2013 10:48:37 +0100
Subject: [PATCH] mfd: stmpe: Pull IRQ GPIO number from DT during DT-based
 probe
In-Reply-To: <201301081044.14876.marex@denx.de>
References: <1357568989-16237-1-git-send-email-marex@denx.de>
 <20130108094134.GA21994@gmail.com> <201301081044.14876.marex@denx.de>
Message-ID: <201301081048.38149.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Lee Jones,

> > > >Both can be killed. gpios as interrupt lines can be requested as:
> > > >  interrupt-parent =<&gpio-controller>;
> > > >  interrupts =<25 0x1>;
> > > >
> > > >and probably the stmpe driver doesn't have to bother at all if
> > > >interrupt was over gpio or not.
> > > 
> > > Yes, both can be killed and similarly we did for spear1340 machine
> > > but some how we missed it on spear320-hmi.
> > 
> > Bingo!
> 
> All right, all right ... got it ;-)
> 
> I'll rework it and repost then.

Maybe I was too quick about understanding the issue at hand. So allow me a 
stupid question -- who's gonna configure the GPIO as input for it to work as IRQ 
GPIO?

Best regards,
Marek Vasut
