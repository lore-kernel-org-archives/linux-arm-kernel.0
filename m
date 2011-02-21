From: w.sang@pengutronix.de (Wolfram Sang)
Date: Mon, 21 Feb 2011 18:40:16 +0100
Subject: [PATCH v3] mmc: mxs-mmc: add mmc host driver for i.MX23/28
In-Reply-To: <1298284528-14761-1-git-send-email-shawn.guo@freescale.com>
References: <1298284528-14761-1-git-send-email-shawn.guo@freescale.com>
Message-ID: <20110221174016.GN2616@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shawn,

On Mon, Feb 21, 2011 at 06:35:28PM +0800, Shawn Guo wrote:
> This adds the mmc host driver for Freescale MXS-based SoC i.MX23/28.
> The driver calls into mxs-dma via generic dmaengine api for both pio
> and data transfer.
> 
> Thanks Chris Ball for the indentation patch.
> 
> Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>

What throughput rates do you get on a mx28-regulated slot serving a card
at 50Mhz? This is poor here (55kb/s) while it is OK at 25Mhz. Could be a
board issue though (or we can fix it later), rest works fine, thus:

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110221/8244f36f/attachment.sig>
