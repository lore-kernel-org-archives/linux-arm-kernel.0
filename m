From: broonie@kernel.org (Mark Brown)
Date: Tue, 12 May 2015 20:17:58 +0100
Subject: [PATCH] spi: omap2-mcspi: Fix native cs with new set_cs
In-Reply-To: <1431452337-19280-1-git-send-email-mwelling@ieee.org>
References: <1431452337-19280-1-git-send-email-mwelling@ieee.org>
Message-ID: <20150512191758.GX3066@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 12, 2015 at 12:38:57PM -0500, Michael Welling wrote:
> GPIO chip select patch series appears to have broken the native chip select
> support. This patch pulls the manual native chip select toggling out of
> the transfer_one routine and adds a set_cs routine.

Applied, thanks
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150512/cf6d9bba/attachment.sig>
