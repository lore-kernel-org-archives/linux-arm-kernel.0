From: broonie@kernel.org (Mark Brown)
Date: Mon, 24 Nov 2014 18:53:49 +0000
Subject: [PATCH v3 1/4] spi: core: Add spi_transfer_is_last() helper
In-Reply-To: <1416669702-7841-2-git-send-email-b.galvani@gmail.com>
References: <1416669702-7841-1-git-send-email-b.galvani@gmail.com>
 <1416669702-7841-2-git-send-email-b.galvani@gmail.com>
Message-ID: <20141124185349.GC7712@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 22, 2014 at 04:21:39PM +0100, Beniamino Galvani wrote:
> This adds the function spi_transfer_is_last() which can be used by
> drivers to know whether a given transfer is the last one in the
> current message.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141124/d6850d0e/attachment.sig>
