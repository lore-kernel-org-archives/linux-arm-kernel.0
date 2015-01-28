From: broonie@kernel.org (Mark Brown)
Date: Wed, 28 Jan 2015 17:37:42 +0000
Subject: [PATCH] spi: pl08x: do not select S3C64XX_PL080
In-Reply-To: <2608153.sC21ihDxEF@wuerfel>
References: <1957186.KORYFIrP42@wuerfel>
 <2608153.sC21ihDxEF@wuerfel>
Message-ID: <20150128173742.GA21293@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 28, 2015 at 02:27:06PM +0100, Arnd Bergmann wrote:
> The pl08x driver originally selected S3C64XX_PL080 to avoid having
> the legacy Samsung DMA interfaces. Those are now gone, so the
> select is no longer needed, but it now causes problems when
> CONFIG_DMA_ENGINE is disabled:

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150128/df81a75a/attachment.sig>
