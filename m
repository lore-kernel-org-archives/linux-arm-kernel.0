From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 29 May 2013 22:26:50 +0800
Subject: [PATCH v6 03/10] ASoC: imx-pcm-fiq: Introduce pcm-fiq-params
In-Reply-To: <1369752478-30260-4-git-send-email-mpa@pengutronix.de>
References: <1369752478-30260-1-git-send-email-mpa@pengutronix.de>
 <1369752478-30260-4-git-send-email-mpa@pengutronix.de>
Message-ID: <20130529142648.GC29528@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 28, 2013 at 04:47:51PM +0200, Markus Pargmann wrote:
> @@ -47,7 +56,8 @@ static inline void imx_pcm_dma_exit(struct platform_device *pdev)
>  #endif
>  
>  #ifdef CONFIG_SND_SOC_IMX_PCM_FIQ
> -int imx_pcm_fiq_init(struct platform_device *pdev);
> +int imx_pcm_fiq_init(struct platform_device *pdev,
> +		struct imx_pcm_fiq_params *params);
>  void imx_pcm_fiq_exit(struct platform_device *pdev);
>  #else
>  static inline int imx_pcm_fiq_init(struct platform_device *pdev)

This one also needs update with a new parameter.

Shawn
