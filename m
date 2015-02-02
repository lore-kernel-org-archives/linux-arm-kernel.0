From: broonie@kernel.org (Mark Brown)
Date: Mon, 2 Feb 2015 12:25:32 +0000
Subject: imx6dl, spi: read/write problem with SPI-NOR on imx6d
In-Reply-To: <20150202035430.GA27494@Robin-OptiPlex-780>
References: <54CB6D8F.5010804@denx.de>
 <20150202035430.GA27494@Robin-OptiPlex-780>
Message-ID: <20150202122532.GS21293@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 02, 2015 at 11:54:31AM +0800, Robin Gong wrote:
> On Fri, Jan 30, 2015 at 12:39:59PM +0100, Heiko Schocher wrote:

> > and I could not see in the commit f62caccd, that DMA gets disabled
> > for imx6dl ... Is this missing? Or should this be done in the board
> > specific DTS?

> Yes, the patch about DTS was dropped as below. Sorry, the next patch not ready
> yet, I'll create it once I have time...
> https://lkml.org/lkml/2014/9/10/91

If this is breaking users then a patch providing the fix needs to be
done fairly urgently, and given that we're supposed to have stable DTs
we probably need a quirk based on SoC type in the driver as well.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150202/77fb38c2/attachment.sig>
