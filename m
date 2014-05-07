From: broonie@kernel.org (Mark Brown)
Date: Wed, 7 May 2014 20:50:30 +0100
Subject: [PATCH] spi: atmel: fix incorrect comparison
In-Reply-To: <1399391081-16095-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1399391081-16095-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <20140507195030.GM22111@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 06, 2014 at 05:44:41PM +0200, Alexandre Belloni wrote:
> Found using smatch:
> drivers/spi/spi-atmel.c:878 atmel_spi_pump_pio_data() warn: unsigned
> 'as->current_remaining_bytes' is never less than zero.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140507/48f1521b/attachment.sig>
