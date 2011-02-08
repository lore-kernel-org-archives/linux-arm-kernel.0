From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 9 Feb 2011 06:59:58 +0800
Subject: [PATCH 1/5] dmaengine: mxs-dma: add dma support for i.MX23/28
In-Reply-To: <20110205153300.GA29411@n2100.arm.linux.org.uk>
References: <1296871696-21008-1-git-send-email-shawn.guo@freescale.com>
	<1296871696-21008-2-git-send-email-shawn.guo@freescale.com>
	<20110205153300.GA29411@n2100.arm.linux.org.uk>
Message-ID: <20110208225957.GA6963@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Sat, Feb 05, 2011 at 03:33:00PM +0000, Russell King - ARM Linux wrote:
> Shawn,
> 
> A couple more points below.
> 
> On Sat, Feb 05, 2011 at 10:08:12AM +0800, Shawn Guo wrote:
> > +	mxs_dma->dev = &pdev->dev;
> ...
> > +	mxs_dma->dma_device.dev = &pdev->dev;
> 
> Do you need mxs_dma->dev, or could you just use mxs_dma->dma_device.dev
> throughout?
> 
OK.

> > +static int __exit mxs_dma_remove(struct platform_device *pdev)
> > +{
> > +	return -EBUSY;
> > +}
> 
> As the return code is ignored, it's probably better to omit the remove
> function entirely.
> 
OK.

Regards,
Shawn
