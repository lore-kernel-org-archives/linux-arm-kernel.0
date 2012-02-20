From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sun, 19 Feb 2012 18:14:34 -0800
Subject: [PATCH] ASoC: Add __devinit annotation for pxa2xx_ac97_probe
In-Reply-To: <1329696290.16979.1.camel@phoenix>
References: <1329696290.16979.1.camel@phoenix>
Message-ID: <20120220021432.GG3194@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 20, 2012 at 08:04:50AM +0800, Axel Lin wrote:
> This fixes below build warning:
> WARNING: vmlinux.o(.text+0x1e632c): Section mismatch in reference from the function pxa2xx_ac97_probe() to the function .devinit.text:pxa2xx_ac97_hw_probe()
> The function pxa2xx_ac97_probe() references
> the function __devinit pxa2xx_ac97_hw_probe().
> This is often because pxa2xx_ac97_probe lacks a __devinit
> annotation or the annotation of pxa2xx_ac97_hw_probe is wrong.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120219/b0774825/attachment.sig>
