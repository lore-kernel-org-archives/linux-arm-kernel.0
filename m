From: broonie@kernel.org (Mark Brown)
Date: Wed, 20 May 2015 19:06:36 +0100
Subject: [PATCH] ASoC: omap: fix up SND_OMAP_SOC_OMAP_ABE_TWL6040
 dependency, again
In-Reply-To: <3413182.qcoNiOhonF@wuerfel>
References: <3413182.qcoNiOhonF@wuerfel>
Message-ID: <20150520180636.GK21577@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 19, 2015 at 02:47:32PM +0200, Arnd Bergmann wrote:
> I tried to fix this before and submitted a working patch, but after
> some discussion we came up with what seemed to be a nicer solution,
> resulting in commit 3d4cf65e2d ("ASoC: omap: fix up
> SND_OMAP_SOC_OMAP_ABE_TWL6040 dependency"). Unfortunately, that
> version was incomplete, and we still get this build error:

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150520/6bc10918/attachment.sig>
