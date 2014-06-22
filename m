From: broonie@kernel.org (Mark Brown)
Date: Sun, 22 Jun 2014 11:58:32 +0100
Subject: [PATCH] ASoC: fsl: refine DMA/FIQ dependencies
In-Reply-To: <6452477.9e3eS6Cip1@wuerfel>
References: <6452477.9e3eS6Cip1@wuerfel>
Message-ID: <20140622105832.GO24291@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 03, 2014 at 02:11:56PM +0200, Arnd Bergmann wrote:
> Commit 31ee2bfd724ab ("ASoC: fsl: select SND_SOC_IMX_PCM_DMA
> where needed") started selecting SND_SOC_IMX_PCM_DMA and
> SND_SOC_IMX_PCM_FIQ for two drivers when building for i.MX.
> This has turned out too aggressive, as FIQ is only available
> for i.mx2 through i.mx5, but not i.mx6 or vybrid.

Applied, thanks.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140622/bd8d80d2/attachment.sig>
