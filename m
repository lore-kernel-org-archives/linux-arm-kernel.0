From: w.sang@pengutronix.de (Wolfram Sang)
Date: Mon, 28 Feb 2011 15:20:38 +0100
Subject: [PATCH V3 3/4] mmc: sdhci-esdhc: remove
	SDHCI_QUIRK_NO_CARD_NO_RESET from ESDHC_DEFAULT_QUIRKS
In-Reply-To: <1298892725-23672-3-git-send-email-Hong-Xing.Zhu@freescale.com>
References: <1298892725-23672-1-git-send-email-Hong-Xing.Zhu@freescale.com>
	<1298892725-23672-3-git-send-email-Hong-Xing.Zhu@freescale.com>
Message-ID: <20110228142037.GE15532@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 28, 2011 at 07:32:04PM +0800, Richard Zhu wrote:
> sdhci-esdhc-imx does not need SDHCI_QUIRK_NO_CARD_NO_RESET. Make it OF-specific.
> 
> Signed-off-by: Richard Zhu <Hong-Xing.Zhu@freescale.com>

Seems to work on mx35 at least:

Tested-by: Wolfram Sang <w.sang@pengutronix.de>

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110228/3b4ad884/attachment.sig>
