From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 27 Jun 2012 12:47:21 +0100
Subject: [PATCH V3 1/1] ASoC: tlv320aic3x: Fix codec pll configure bug
In-Reply-To: <1340718911-9325-1-git-send-email-gururaja.hebbar@ti.com>
References: <1340718911-9325-1-git-send-email-gururaja.hebbar@ti.com>
Message-ID: <20120627114721.GI308@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 26, 2012 at 07:25:11PM +0530, Hebbar, Gururaja wrote:
> In sound/soc/codecs/tlv320aic3x.c
> 
>         data = snd_soc_read(codec, AIC3X_PLL_PROGA_REG);
>         snd_soc_write(codec, AIC3X_PLL_PROGA_REG,
>                       data | (pll_p << PLLP_SHIFT));

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120627/1e0ab685/attachment.sig>
