From: broonie@kernel.org (Mark Brown)
Date: Thu, 17 Jul 2014 19:48:04 +0100
Subject: [PATCH 2/4] spi: s3c64xx: use the generic SPI "cs-gpios" property
In-Reply-To: <1405523950-2231-3-git-send-email-javier.martinez@collabora.co.uk>
References: <1405523950-2231-1-git-send-email-javier.martinez@collabora.co.uk>
 <1405523950-2231-3-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <20140717184804.GC17528@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 16, 2014 at 05:19:08PM +0200, Javier Martinez Canillas wrote:
> From: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
> 
> The s3c64xx SPI driver uses a custom DT binding to specify
> the GPIO used to drive the chip select (CS) line instead of
> using the generic "cs-gpios" property already defined in:
> Documentation/devicetree/bindings/spi/spi-bus.txt.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140717/417cc2a7/attachment-0001.sig>
