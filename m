From: broonie@kernel.org (Mark Brown)
Date: Sat, 20 Feb 2016 00:51:03 +0900
Subject: [PATCH 04/12] spi: imx: drop fallback to PIO
In-Reply-To: <1455867792-26389-5-git-send-email-s.hauer@pengutronix.de>
References: <1455867792-26389-1-git-send-email-s.hauer@pengutronix.de>
 <1455867792-26389-5-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20160219155103.GS18327@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 19, 2016 at 08:43:04AM +0100, Sascha Hauer wrote:
> At the moment the driver decides to fallback to PIO mode the buffers
> are already mapped for DMA. It's a bug to access them with the CPU
> afterwards, so we cannot just fallback to PIO mode.

This doesn't apply against current code, please check and resend.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160220/a63b0592/attachment.sig>
