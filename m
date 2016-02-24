From: broonie@kernel.org (Mark Brown)
Date: Wed, 24 Feb 2016 12:19:36 +0900
Subject: [PATCH] spi: imx: initialize usedma earlier
In-Reply-To: <1456223095-32185-1-git-send-email-s.hauer@pengutronix.de>
References: <20160223111559.3c2cb641@ipc1.ka-ro>
 <1456223095-32185-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20160224031936.GI18327@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 23, 2016 at 11:24:55AM +0100, Sascha Hauer wrote:
> The SoC specific config function does not know if DMA will be used or
> not. This information will be useful to configure the SPI controller
> correctly for DMA in following patches, so initialize the usedma
> variable before calling into the SoC specific config function.

Don't send new patches in reply to old serieses, especially not in the
middle of them - it makes it confusing to follow what's going on.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160224/e4e85b54/attachment-0001.sig>
