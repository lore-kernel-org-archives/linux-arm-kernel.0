From: broonie@kernel.org (Mark Brown)
Date: Thu, 1 May 2014 13:54:20 -0700
Subject: [alsa-devel] [PATCH] ASoC: fsl: select SND_SOC_IMX_PCM_DMA where
 needed
In-Reply-To: <5363504.ttXVrGSYNO@wuerfel>
References: <6606961.lAGLvkNsEj@wuerfel> <20140429165630.GD16981@sirena.org.uk>
 <8655908.M1OtjG8JKI@wuerfel> <5363504.ttXVrGSYNO@wuerfel>
Message-ID: <20140501205420.GF3245@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 29, 2014 at 09:36:22PM +0200, Arnd Bergmann wrote:
> Since commit 204dec93eaa "ASoC: fsl: Allow to select individual common
> options", it is possible to enable SND_SOC_FSL_SSI and SND_SOC_FSL_SPDIF
> manually, either as loadable modules or built-in. This unfortunately
> leads to a link error if one or both of them are built-in, while
> the imx-pcm-dma framework is a loadable module:

Applied, thanks.  Please don't send patches in reply to existing threads
(especially with the Re - it makes it look like ongoing discussion, I at
least often leave these discussions among people working on the platform
to grind on).
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140501/3c17db80/attachment.sig>
