From: broonie@kernel.org (Mark Brown)
Date: Tue, 18 Nov 2014 14:28:24 +0000
Subject: [PATCH v2 3/4] spi: meson: Add support for Amlogic Meson SPIFC
In-Reply-To: <1416264471-774-4-git-send-email-b.galvani@gmail.com>
References: <1416264471-774-1-git-send-email-b.galvani@gmail.com>
 <1416264471-774-4-git-send-email-b.galvani@gmail.com>
Message-ID: <20141118142824.GJ22111@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 17, 2014 at 11:47:50PM +0100, Beniamino Galvani wrote:
> This is a driver for the Amlogic Meson SPIFC (SPI flash controller),
> which is one of the two SPI controllers available on the SoC. It
> doesn't support DMA and has a 64-byte unified transmit/receive buffer.

This is all good.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141118/8ff574f9/attachment.sig>
