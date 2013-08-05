From: broonie@kernel.org (Mark Brown)
Date: Mon, 5 Aug 2013 15:49:50 +0100
Subject: [PATCH RFC 01/13] ASoC: kirkwood: merge struct kirkwood_dma_priv
 with struct kirkwood_dma_data
In-Reply-To: <E1V63sR-0004lC-0g@rmk-PC.arm.linux.org.uk>
References: <20130804192136.GK23006@n2100.arm.linux.org.uk>
 <E1V63sR-0004lC-0g@rmk-PC.arm.linux.org.uk>
Message-ID: <20130805144950.GH9858@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 04, 2013 at 08:22:03PM +0100, Russell King wrote:
> Merge these two structures together; nothing other than the I2S and
> DMA driver makes use of struct kirkwood_dma_data, and it's not like
> struct kirkwood_dma_data is really just used to convey DMA specific
> data to the backend; it's more a general shared structure between the
> two halves.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130805/10cad285/attachment.sig>
