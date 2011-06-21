From: w.sang@pengutronix.de (Wolfram Sang)
Date: Tue, 21 Jun 2011 13:52:36 +0200
Subject: [PATCH v3 2/4] mmc: sdhci-esdhc-imx: SDHCI_CARD_PRESENT does not
	get cleared
In-Reply-To: <1308566325-11600-3-git-send-email-shawn.guo@linaro.org>
References: <1308566325-11600-1-git-send-email-shawn.guo@linaro.org>
	<1308566325-11600-3-git-send-email-shawn.guo@linaro.org>
Message-ID: <20110621115236.GA14004@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 20, 2011 at 06:38:43PM +0800, Shawn Guo wrote:
> The function esdhc_readl_le intends to clear bit SDHCI_CARD_PRESENT,
> when the card detect gpio tells there is no card.  But it does not
> clear the bit actually.  The patch gives a fix on that.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>

For the third time ;)

Acked-by: Wolfram Sang <w.sang@pengutronix.de>

Should go to stable.

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110621/e2753a7f/attachment.sig>
