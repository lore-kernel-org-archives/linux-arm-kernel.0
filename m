From: broonie@kernel.org (Mark Brown)
Date: Mon, 24 Nov 2014 18:55:05 +0000
Subject: [PATCH v3 3/4] spi: meson: Add support for Amlogic Meson SPIFC
In-Reply-To: <1416669702-7841-4-git-send-email-b.galvani@gmail.com>
References: <1416669702-7841-1-git-send-email-b.galvani@gmail.com>
 <1416669702-7841-4-git-send-email-b.galvani@gmail.com>
Message-ID: <20141124185505.GE7712@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 22, 2014 at 04:21:41PM +0100, Beniamino Galvani wrote:
> This is a driver for the Amlogic Meson SPIFC (SPI flash controller),
> which is one of the two SPI controllers available on the SoC. It
> doesn't support DMA and has a 64-byte unified transmit/receive buffer.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141124/2015c5a1/attachment.sig>
