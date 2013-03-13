From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 13 Mar 2013 10:18:29 +0800
Subject: [PATCH 08/10] ASoC: dmaengine_pcm: Add open function for DT DMA
 request
In-Reply-To: <20130312190206.GY19942@opensource.wolfsonmicro.com>
References: <1362940391-8338-1-git-send-email-mpa@pengutronix.de>
 <1362940391-8338-9-git-send-email-mpa@pengutronix.de>
 <20130312190206.GY19942@opensource.wolfsonmicro.com>
Message-ID: <20130313021712.GD27461@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 12, 2013 at 07:02:07PM +0000, Mark Brown wrote:
> On Sun, Mar 10, 2013 at 07:33:09PM +0100, Markus Pargmann wrote:
> > Add a function to open a DMA PCM substream using devicetree data
> > provided via the client device node. The patch introduces a public
> > function and a private subfunction that is called by both open
> > functions.
> 
> Someone (I think it was Shawn) sent a very similar patch just recently
> which appears to have fallen out of my inbox unfortunately - can you
> please check what's going on there and coordinate with them?  Let me
> know if you can't find the patch and I'll dig it out.

It's here, Markus.

http://thread.gmane.org/gmane.linux.alsa.devel/106027/focus=106031

Mark,

I did not see any objection from you on that patch, so I'm waiting for
you to publish a branch for it, so that my mxs-dma generic binding
series can move forward.

Shawn
