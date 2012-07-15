From: shawn.guo@freescale.com (Shawn Guo)
Date: Sun, 15 Jul 2012 16:17:16 +0800
Subject: [PATCH 2/2 V3] MXS: Implement DMA support into mxs-i2c
In-Reply-To: <20120713082249.GF32184@pengutronix.de>
References: <1341850974-11977-1-git-send-email-marex@denx.de>
 <1341850974-11977-2-git-send-email-marex@denx.de>
 <20120713082249.GF32184@pengutronix.de>
Message-ID: <20120715081715.GA2429@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 13, 2012 at 10:22:49AM +0200, Wolfram Sang wrote:
> > +	/*
> > +	 * TODO: This is a temporary solution and should be changed
> > +	 * to use generic DMA binding later when the helpers get in.
> > +	 */
> 
> @Shawn: Any idea when this is going to happen? And why do we need this?

See thread [1] for current statues.  I'm not sure when it's going to
happen though.

> AFAICT it will be always channel 6/7 on mx28?
> 
Yes, but it might be a different channel on mx23.  Just like we define
IO region and interrupt number in device tree, dma channel is just
another resource of hardware block that we choose to define in device
tree.

Regards,
Shawn

[1] http://thread.gmane.org/gmane.linux.ports.arm.omap/75828
