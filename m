From: w.sang@pengutronix.de (Wolfram Sang)
Date: Mon, 21 Feb 2011 11:02:26 +0100
Subject: [PATCH 4/5] mm: sdhci-esdhc: remove
	SDHCI_QUIRK_NO_CARD_NO_RESET from ESDHC_DEFAULT_QUIRKS
In-Reply-To: <1298282095-2279-4-git-send-email-richard.zhao@freescale.com>
References: <1298282095-2279-1-git-send-email-richard.zhao@freescale.com>
	<1298282095-2279-4-git-send-email-richard.zhao@freescale.com>
Message-ID: <20110221100226.GD2616@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 21, 2011 at 05:54:54PM +0800, Richard Zhao wrote:
> sdhci-esdhc-imx does not need SDHCI_QUIRK_NO_CARD_NO_RESET.
> Make it OF-specific.

Just to make sure, because all the other patches are for mx53: Do you
have tested it on mx25/35/51 also?

Regards,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110221/68f6d0be/attachment.sig>
