From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 1 May 2012 21:58:03 +0800
Subject: [PATCH 2/2] I2C: Implement DMA support into mxs-i2c
In-Reply-To: <20120430210108.GE28226@pengutronix.de>
References: <1335738969-27445-1-git-send-email-marex@denx.de>
 <201204302207.39112.marex@denx.de>
 <20120430203016.GD28226@pengutronix.de>
 <201204302245.57958.marex@denx.de>
 <20120430210108.GE28226@pengutronix.de>
Message-ID: <20120501135800.GL2194@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 30, 2012 at 11:01:08PM +0200, Wolfram Sang wrote:
> 
> > > > It complains that data might be undefined, do you want it in a separate
> > > > patch then ?
> > > 
> > > Yes, but only if you can prove that the compiler is right.
> > 
> > It's not right, because that variable is always initialized, but this at least 
> > squashes the compile warning.
> 
> The compiler needs to be fixed, not the kernel.
> 
Heh, this is coming up again.  I'm not convincing you to take the
change, but just curious what if this is not a compile warning but
an error for the same cause that compiler is not right.

-- 
Regards,
Shawn
