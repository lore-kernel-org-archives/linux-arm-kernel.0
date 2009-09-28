From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Mon, 28 Sep 2009 09:56:34 +0200 (CEST)
Subject: [PATCH needed?] ARM: add missing HAVE_KERNEL_GZIP
In-Reply-To: <20090928075313.GA22380@pengutronix.de>
References: <Pine.LNX.4.64.0909280914220.4212@axis700.grange>
	<20090928075313.GA22380@pengutronix.de>
Message-ID: <Pine.LNX.4.64.0909280954490.4212@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 28 Sep 2009, Uwe Kleine-K?nig wrote:

> Hi Guennadi,
> 
> On Mon, Sep 28, 2009 at 09:21:35AM +0200, Guennadi Liakhovetski wrote:
> > Kernel fails to uncompress itself and boot without this patch.
> I have no problem booting yesterday's linus/master without that change.
> 
> What is the exact problem you see?

Don't remember the error message exactly - something like "cannot 
uncompress" or "missing decompressor"... Observed on a i.MX31 system, 
although, if the problem were real, it probably would be present on all 
ARMs - none defines any of those decompressors. Will have to double-check 
then.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
