From: mturquette@linaro.org (Mike Turquette)
Date: Mon, 12 Aug 2013 12:45:42 -0700
Subject: [PATCH 16/18] clk: samsung: s3c64xx: Remove clock aliases of old
 DMA driver
In-Reply-To: <1376243970-6489-17-git-send-email-tomasz.figa@gmail.com>
References: <1376243970-6489-1-git-send-email-tomasz.figa@gmail.com>
 <1376243970-6489-17-git-send-email-tomasz.figa@gmail.com>
Message-ID: <20130812194542.5348.7468@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Tomasz Figa (2013-08-11 10:59:28)
> Since the old DMA driver got removed, these aliases are no longer
> necessary.
> 
> Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>

Acked-by: Mike Turquette <mturquette@linaro.org>

> ---
>  drivers/clk/samsung/clk-s3c64xx.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/clk/samsung/clk-s3c64xx.c b/drivers/clk/samsung/clk-s3c64xx.c
> index 79ee9a6..dd47a83 100644
> --- a/drivers/clk/samsung/clk-s3c64xx.c
> +++ b/drivers/clk/samsung/clk-s3c64xx.c
> @@ -331,9 +331,7 @@ static struct samsung_clock_alias s3c64xx_clock_aliases[] = {
>         ALIAS(HCLK_HSMMC1, "s3c-sdhci.1", "mmc_busclk.0"),
>         ALIAS(HCLK_HSMMC0, "s3c-sdhci.0", "hsmmc"),
>         ALIAS(HCLK_HSMMC0, "s3c-sdhci.0", "mmc_busclk.0"),
> -       ALIAS(HCLK_DMA1, NULL, "dma1"),
>         ALIAS(HCLK_DMA1, "dma-pl080s.1", "apb_pclk"),
> -       ALIAS(HCLK_DMA0, NULL, "dma0"),
>         ALIAS(HCLK_DMA0, "dma-pl080s.0", "apb_pclk"),
>         ALIAS(HCLK_CAMIF, "s3c-camif", "camif"),
>         ALIAS(HCLK_LCD, "s3c-fb", "lcd"),
> -- 
> 1.8.3.2
