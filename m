From: marex@denx.de (Marek Vasut)
Date: Wed, 6 Mar 2013 00:28:18 +0100
Subject: [PATCH v3 09/12] ASoC: dmaengine_pcm: add
 snd_dmaengine_generic_pcm_open()
In-Reply-To: <1362494247-28909-1-git-send-email-shawn.guo@linaro.org>
References: <1362486244-24593-10-git-send-email-shawn.guo@linaro.org>
 <1362494247-28909-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <201303060028.18625.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

> With generic DMA device tree binding and helper function
> dma_request_slave_channel() in place, dmaengine_pcm should support
> that in requesting DMA channel for users that support generic DMA
> device tree binding.
> 
> Add a new API snd_dmaengine_generic_pcm_open() as the variant of
> snd_dmaengine_pcm_open().  It takes DMA client struct device pointer
> and slave channel name as arguments and calls generic DMA helper
> dma_request_slave_channel() to request DMA channel from dmaengine.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
> Cc: alsa-devel at alsa-project.org
> ---
> Changes since v2:
>  - Drop 'const' from argument 'name' to fix the warning below.
> 
[...]

v3 changelog missing ;-) What did you adjust here please?

Best regards,
Marek Vasut
