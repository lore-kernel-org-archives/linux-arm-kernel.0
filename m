From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 13 Apr 2016 09:38:42 +0800
Subject: [PATCH] ARM: mach-imx: sdhci-esdhc-imx: initialize DMA mask
In-Reply-To: <1460362846-2906-1-git-send-email-akurz@blala.de>
References: <1460362846-2906-1-git-send-email-akurz@blala.de>
Message-ID: <20160413013842.GB28903@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 11, 2016 at 10:20:46AM +0200, Alexander Kurz wrote:
> With commit 7b91369b DMA access got disabled for device drivers with zero
> DMA mask property. sdhci-esdhc-imx got blocked from DMA access by this.
> Hence: initialize the dma mask to enable access again.
> 
> Signed-off-by: Alexander Kurz <akurz@blala.de>

I fixed up the commit log per comments from Uwe and Sergei, and then
applied the patch as a fix for v4.6-rc.

Shawn
