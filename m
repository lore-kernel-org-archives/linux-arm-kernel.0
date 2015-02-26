From: broonie@kernel.org (Mark Brown)
Date: Thu, 26 Feb 2015 11:34:38 +0900
Subject: [PATCH 1/1] spi: atmel: Fix interrupt setup for PDC transfers
In-Reply-To: <1424791977-2178-1-git-send-email-torfl6749@gmail.com>
References: <1424791977-2178-1-git-send-email-torfl6749@gmail.com>
Message-ID: <20150226023438.GF6236@finisterre.sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 24, 2015 at 04:32:57PM +0100, Torsten Fleischer wrote:
> From: Torsten Fleischer <torfl6749@gmail.com>
> 
> Additionally to the current DMA transfer the PDC allows to set up a next DMA
> transfer. This is useful for larger SPI transfers.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150226/6efb6cc6/attachment.sig>
