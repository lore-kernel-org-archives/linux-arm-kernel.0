From: w.sang@pengutronix.de (Wolfram Sang)
Date: Tue, 25 Sep 2012 08:44:43 +0200
Subject: [PATCH] mmc: sdhci / i.MX esdhc buswidth patches
In-Reply-To: <1348471345-30785-1-git-send-email-s.hauer@pengutronix.de>
References: <1348471345-30785-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20120925064443.GA8655@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 24, 2012 at 09:22:22AM +0200, Sascha Hauer wrote:
> The first patch is a generic sdhci driver cleanup change, the others
> are i.MX specific, adding 8bit bus support and fix version register
> readout.
> 
> Sascha
> 
> ----------------------------------------------------------------
> Sascha Hauer (3):
>       mmc: sdhci: rename platform_8bit_width to platform_bus_width
>       mmc: esdhc i.MX: Fix version register read
>       mmc: esdhc i.MX: Support 8bit mode

Whole series:

Acked-by: Wolfram Sang <w.sang@pengutronix.de>

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120925/9d27a5b4/attachment.sig>
