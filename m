From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 1 May 2012 22:09:12 +0800
Subject: [PATCH 2/2] I2C: Implement DMA support into mxs-i2c
In-Reply-To: <201205011602.56563.marex@denx.de>
References: <1335738969-27445-1-git-send-email-marex@denx.de>
 <20120430210108.GE28226@pengutronix.de>
 <20120501135800.GL2194@S2101-09.ap.freescale.net>
 <201205011602.56563.marex@denx.de>
Message-ID: <20120501140910.GM2194@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 01, 2012 at 04:02:56PM +0200, Marek Vasut wrote:
> Dear Shawn Guo,
> 
> > On Mon, Apr 30, 2012 at 11:01:08PM +0200, Wolfram Sang wrote:
> > > > > > It complains that data might be undefined, do you want it in a
> > > > > > separate patch then ?
> > > > > 
> > > > > Yes, but only if you can prove that the compiler is right.
> > > > 
> > > > It's not right, because that variable is always initialized, but this
> > > > at least squashes the compile warning.
> > > 
> > > The compiler needs to be fixed, not the kernel.
> 
> I second this.
> 
I agree on this too.

> > Heh, this is coming up again.  I'm not convincing you to take the
> > change, but just curious what if this is not a compile warning but
> > an error for the same cause that compiler is not right.
> 
> Can you elaborate?
> 
Will we have the kernel not compilable for a few cycles until the
compiler fixing is available, or we work it around to keep kernel
compiling and working before we have the compiler fixed?

-- 
Regards,
Shawn
