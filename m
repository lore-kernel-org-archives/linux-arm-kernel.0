From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sun, 10 Jul 2011 17:21:48 +0900
Subject: [PATCH 01/10] ASoc: mxs: add mxs-pcm driver
In-Reply-To: <CAA+hA=ROnBkLFbZgvbP_XtmbqALKGBqLbZXquxe-HYOg-xhJqg@mail.gmail.com>
References: <1310140790-2132-1-git-send-email-b29396@freescale.com>
	<1310140790-2132-2-git-send-email-b29396@freescale.com>
	<20110709023358.GB26900@sirena.org.uk>
	<CAA+hA=ROnBkLFbZgvbP_XtmbqALKGBqLbZXquxe-HYOg-xhJqg@mail.gmail.com>
Message-ID: <20110710082146.GA23199@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 10, 2011 at 02:28:26PM +0800, Dong Aisheng wrote:
> 2011/7/9 Mark Brown <broonie@opensource.wolfsonmicro.com>:
> > On Fri, Jul 08, 2011 at 11:59:41PM +0800, Dong Aisheng wrote:

> >> + * Refer to sound/soc/imx/imx-pcm-dma-mx2.c

> > Why?

> Just with the reference of  imx-pcm-dma-mx2.c code.

What is the relevance of that specific code compared to other DMA
drivers, though?
