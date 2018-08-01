From: broonie@kernel.org (Mark Brown)
Date: Wed, 1 Aug 2018 18:27:47 +0100
Subject: [RFC PATCH v2 5/6] spi: Add QuadSPI driver for Atmel SAMA5D2
In-Reply-To: <20180627131609.13681-6-bugalski.piotr@gmail.com>
References: <20180627131609.13681-1-bugalski.piotr@gmail.com>
 <20180627131609.13681-6-bugalski.piotr@gmail.com>
Message-ID: <20180801172747.GJ5509@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 27, 2018 at 03:16:08PM +0200, Piotr Bugalski wrote:
> Kernel contains QSPI driver strongly tied to MTD and nor-flash memory.
> New spi-mem interface allows usage also other memory types, especially
> much larger NAND with SPI interface. This driver works as SPI controller
> and is not related to MTD, however can work with NAND-flash or other
> peripherals using spi-mem interface.

This is fine from a SPI point of view but I'd like to apply it directly
to the SPI tree rather than ack it for merge via the MTD tree - can we
work something out with a shared branch or something?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180801/c4c773c3/attachment.sig>
