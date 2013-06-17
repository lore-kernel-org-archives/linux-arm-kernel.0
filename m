From: broonie@kernel.org (Mark Brown)
Date: Mon, 17 Jun 2013 11:43:27 +0100
Subject: [PATCH v10 1/2] ARM: davinci: move private EDMA API to arm/common
In-Reply-To: <1371463571-2578-2-git-send-email-nsekhar@ti.com>
References: <1371463571-2578-1-git-send-email-nsekhar@ti.com>
 <1371463571-2578-2-git-send-email-nsekhar@ti.com>
Message-ID: <20130617104327.GD1403@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 17, 2013 at 03:36:10PM +0530, Sekhar Nori wrote:
> From: Matt Porter <mporter@ti.com>
> 
> Move mach-davinci/dma.c to common/edma.c so it can be used
> by OMAP (specifically AM33xx) as well.
> 
> Signed-off-by: Matt Porter <mporter@ti.com>
> Acked-by: Chris Ball <cjb@laptop.org> # davinci_mmc.c
> [nsekhar at ti.com: dropped davinci sffsdr changes]
> Signed-off-by: Sekhar Nori <nsekhar@ti.com>

Acked-by: Mark Brown <broonie@linaro.org>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130617/5ea59388/attachment.sig>
