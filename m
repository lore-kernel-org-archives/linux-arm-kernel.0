From: jun.nie@linaro.org (Jun Nie)
Date: Thu, 8 Dec 2016 22:58:02 +0800
Subject: [PATCH 2/2] ASoC: zte: spdif: correct ZX_SPDIF_CLK_RAT define
In-Reply-To: <1481186655-8213-2-git-send-email-shawnguo@kernel.org>
References: <1481186655-8213-1-git-send-email-shawnguo@kernel.org>
 <1481186655-8213-2-git-send-email-shawnguo@kernel.org>
Message-ID: <CABymUCNG1XfcsnRi+w5R6k4YvWP9-f8TMpWHMe7fZ6wRxNGGFA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2016-12-08 16:44 GMT+08:00 Shawn Guo <shawnguo@kernel.org>:
> From: Shawn Guo <shawn.guo@linaro.org>
>
> The macro ZX_SPDIF_CLK_RAT should be 2 instead of 4.  With this
> fix, we can get correct audio output on HDMI through SPDIF interface.
>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
>  sound/soc/zte/zx-spdif.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/sound/soc/zte/zx-spdif.c b/sound/soc/zte/zx-spdif.c
> index 26265ce4caca..9fa6463ce5d7 100644
> --- a/sound/soc/zte/zx-spdif.c
> +++ b/sound/soc/zte/zx-spdif.c
> @@ -71,7 +71,7 @@
>  #define ZX_VALID_RIGHT_TRACK           (2 << 0)
>  #define ZX_VALID_TRACK_MASK            (3 << 0)
>
> -#define ZX_SPDIF_CLK_RAT               (4 * 32)
> +#define ZX_SPDIF_CLK_RAT               (2 * 32)
>
>  struct zx_spdif_info {
>         struct snd_dmaengine_dai_dma_data       dma_data;
> --
> 1.9.1
>

Acked-by: Jun Nie <jun.nie@linaro.org>
