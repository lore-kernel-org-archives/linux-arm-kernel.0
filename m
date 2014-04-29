From: broonie@kernel.org (Mark Brown)
Date: Tue, 29 Apr 2014 09:56:30 -0700
Subject: [alsa-devel] [PATCH] ASoC: fsl: select SND_SOC_IMX_PCM_DMA where
 needed
In-Reply-To: <535FB793.5050200@metafoo.de>
References: <6606961.lAGLvkNsEj@wuerfel> <4270904.84oGcCXL4B@wuerfel>
 <535F8594.40609@metafoo.de> <4275868.O962kiiyJa@wuerfel>
 <535FB793.5050200@metafoo.de>
Message-ID: <20140429165630.GD16981@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 29, 2014 at 04:30:43PM +0200, Lars-Peter Clausen wrote:

> Yes. The patch should also add a select for SND_SOC_IMX_PCM_FIQ as that is
> used in the same way in the fsl_ssi driver. If anybody is afraid that
> selecting both SND_SOC_IMX_PCM_FIQ and SND_SOC_IMX_PCM_DMA by default adds
> too much overhead you could add boolean sub-options that allow to
> enable/disable support individually.

Yes, the overhead should be negligable since the FIQ code is tiny.
Arnd, please CC maintainers on patches - you've sent this to my
Linaro address again and not added Liam.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140429/178cbaa6/attachment.sig>
