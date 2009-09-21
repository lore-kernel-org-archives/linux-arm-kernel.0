From: rene.wolf@mbda-systems.de (Wolf, Rene, HRO-GP)
Date: Mon, 21 Sep 2009 10:22:21 +0200
Subject: SPI, DMA and an i.MX31
In-Reply-To: <BLU105-W229F8F8F533B107510C600BAE10@phx.gbl>
References: <87077C4F48609F4392621D9F99DDE20901202DFF@tesla.star.galaxy.io>
	<BLU105-W229F8F8F533B107510C600BAE10@phx.gbl>
Message-ID: <87077C4F48609F4392621D9F99DDE20901202E00@tesla.star.galaxy.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Marc 

Thanks for your fast reply! 

> in the LTIB kernel sources, you'll find the sources for the freescale
> SDMA API(s) Under linux-2.6.22/arch/arm/plat-mxc/sdma/. Using the
> API is not complicated, you can look in sound/arm/mxc-alsa-pmic.c to
> see an exemple, basically you allocate a channel (mxc_dma_request),
> register a callback handler (mxc_dma_callback_set) and post requests
> (mxc_dma_config).

I did 'download' it (using the script provided by ltib and some manual
labor) -> kernel 2.6.22.6.
At the moment I use 2.6.31 and I'm planning on keeping it that way :-)
Do you think 'porting' that sdma-API would be difficult?
