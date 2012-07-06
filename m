From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 6 Jul 2012 21:45:49 +0800
Subject: [PATCH] dma: mxs-dma: Export missing symbols from mxs-dma.c
In-Reply-To: <1341579200-13268-1-git-send-email-attila@kinali.ch>
References: <20120706122141.GE22133@S2101-09.ap.freescale.net>
 <1341579200-13268-1-git-send-email-attila@kinali.ch>
Message-ID: <20120706134548.GF22133@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 06, 2012 at 02:53:20PM +0200, Attila Kinali wrote:
> mxs-dma.c provides two functions mxs_dma_is_apbh and mxs_dma_is_apbx
> which are used at least in mxs-mmc.c. Building mxs-mmc as module
> fails due to those two symbols not being exported.
> 
> Signed-off-by: Attila Kinali <attila@kinali.ch>

Acked-by: Shawn Guo <shawn.guo@linaro.org>
