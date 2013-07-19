From: broonie@kernel.org (Mark Brown)
Date: Fri, 19 Jul 2013 17:12:52 +0100
Subject: [PATCH 1/6] ASoC: sirf: add sirf platform driver which provides
 DMA
In-Reply-To: <1374232042-26088-2-git-send-email-Baohua.Song@csr.com>
References: <1374232042-26088-1-git-send-email-Baohua.Song@csr.com>
 <1374232042-26088-2-git-send-email-Baohua.Song@csr.com>
Message-ID: <20130719161252.GK9858@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 19, 2013 at 07:07:17PM +0800, Barry Song wrote:

> index 0000000..3678aed
> --- /dev/null
> +++ b/sound/soc/sirf/Kconfig
> @@ -0,0 +1,4 @@
> +config SND_SIRF_SOC
> +	tristate "Platform DMA driver for the SiRF SoC chips"
> +	depends on ARCH_SIRF && SND_SOC
> +	select SND_SOC_DMAENGINE_PCM

Does this have any actual platform build dependencies or can this be
ARCH_SIRF || COMPILE_TEST?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130719/9274cadb/attachment.sig>
