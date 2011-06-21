From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 21 Jun 2011 22:10:34 +0800
Subject: [PATCH v3 2/4] mmc: sdhci-esdhc-imx: SDHCI_CARD_PRESENT does not
	get cleared
In-Reply-To: <20110621115236.GA14004@pengutronix.de>
References: <1308566325-11600-1-git-send-email-shawn.guo@linaro.org>
	<1308566325-11600-3-git-send-email-shawn.guo@linaro.org>
	<20110621115236.GA14004@pengutronix.de>
Message-ID: <20110621141033.GC9228@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 21, 2011 at 01:52:36PM +0200, Wolfram Sang wrote:
> On Mon, Jun 20, 2011 at 06:38:43PM +0800, Shawn Guo wrote:
> > The function esdhc_readl_le intends to clear bit SDHCI_CARD_PRESENT,
> > when the card detect gpio tells there is no card.  But it does not
> > clear the bit actually.  The patch gives a fix on that.
> > 
> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> 
> For the third time ;)
> 
> Acked-by: Wolfram Sang <w.sang@pengutronix.de>
> 
Sorry, my bad.  Will add in v4.

> Should go to stable.
> 
I suppose that Chris will take care of it, otherwise please let me
know what I should do.  (I'm still new to the process)

-- 
Regards,
Shawn
