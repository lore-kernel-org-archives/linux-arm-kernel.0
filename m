From: marex@denx.de (Marek Vasut)
Date: Mon, 30 Apr 2012 23:19:32 +0200
Subject: [PATCH 2/2] I2C: Implement DMA support into mxs-i2c
In-Reply-To: <20120430210108.GE28226@pengutronix.de>
References: <1335738969-27445-1-git-send-email-marex@denx.de>
 <201204302245.57958.marex@denx.de> <20120430210108.GE28226@pengutronix.de>
Message-ID: <201204302319.32619.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Wolfram Sang,

> > > > It complains that data might be undefined, do you want it in a
> > > > separate patch then ?
> > > 
> > > Yes, but only if you can prove that the compiler is right.
> > 
> > It's not right, because that variable is always initialized, but this at
> > least squashes the compile warning.
> 
> The compiler needs to be fixed, not the kernel.
> 
> > > Yes, send V2 with DMA by default, and I will give a try on the
> > > mode-switching later, too.
> > 
> > I'd prefer to have PIOQ by default, to avoid breaking some of the boards.
> > Or can you test on all of them?
> 
> ? What kind of breakage do you expect? I think it is okay if we pull it
> in during the merge window; we can fix issues then till the relase (and
> maybe mode switching works, after all).

Ok, so be it then.

Best regards,
Marek Vasut
