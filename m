From: mika.westerberg@iki.fi (Mika Westerberg)
Date: Wed, 21 Mar 2012 09:07:07 +0200
Subject: [PATCH] ep93xx: Implement double buffering for M2M DMA channels
In-Reply-To: <4F683B36.8090101@metasoft.pl>
References: <4F683B36.8090101@metasoft.pl>
Message-ID: <20120321070707.GA25052@mwesterb-mobl.ger.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 20, 2012 at 09:09:26AM +0100, Rafal Prylowski wrote:
> Implement double buffering for M2M DMA channels.
> 
> Signed-off-by: Rafal Prylowski <prylowski@metasoft.pl>
> 
> Index: slave-dma/drivers/dma/ep93xx_dma.c
> ===================================================================
> --- slave-dma.orig/drivers/dma/ep93xx_dma.c
> +++ slave-dma/drivers/dma/ep93xx_dma.c
> @@ -69,6 +69,7 @@

Which tree this is supposed to apply? I tried both mainline and -next and it
doesn't apply cleanly there.
