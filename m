From: marex@denx.de (Marek Vasut)
Date: Wed, 27 Nov 2013 11:06:09 +0100
Subject: [PATCH 0/4] mtd: spi-nor: add a new framework for SPI NOR
In-Reply-To: <5295BFB3.5020109@ti.com>
References: <1385447575-23773-1-git-send-email-b32955@freescale.com>
 <201311271027.06982.marex@denx.de> <5295BFB3.5020109@ti.com>
Message-ID: <201311271106.09624.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Sourav Poddar,

> Dear Marek Vasut, Huang,
> 
> On Wednesday 27 November 2013 02:57 PM, Marek Vasut wrote:
> > Dear Huang Shijie,
> > 
> >> 1.) Why add a new framework for SPI NOR?
> >> 
> >>    The SPI-NOR controller such as Freescale's Quadspi controller is
> >>    working in a different way from the SPI bus. It should knows the NOR
> >>    commands to find the right LUT sequence. Unfortunately, the current
> >>    code can not meet this requirement.
> > 
> > Is there any kind of documentation for this controller available? I
> > cannot quite understand how this controller works and why can it not be
> > used with our current infrastructure.
> 
> I do have a similar requirement where my controller need to be configured
> from slave info. I have submiited a series in the mtd list adding that
> portion
> of handling such cases. Here, is the patch which specific to m25p80 part.
> http://patchwork.ozlabs.org/patch/294285/
> 
> The whole series can be found here:
> https://www.mail-archive.com/linux-omap at vger.kernel.org/msg98691.html

Is this TI QSPI the same thing as the Altera QSPI controller please ?

Otherwise, I seriously believe you and Huang should work on a common 
infrastructure. I would first like to understand how is the controller in DRA7xx 
different from regular SPI controller though. Is there any kind of documentation 
I could study please?

Best regards,
Marek Vasut
