From: timur@freescale.com (Timur Tabi)
Date: Fri, 16 Mar 2012 16:25:09 -0500
Subject: [PATCH v5] ASoC: add imx-sgtl5000 machine driver working with
 fsl_ssi
In-Reply-To: <1331888204-27058-1-git-send-email-shawn.guo@linaro.org>
References: <1331888204-27058-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <4F63AFB5.8000408@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shawn Guo wrote:
> Changes since v4:
>  * Add new_binding flag for fsl_ssi driver to support both
>    "old binding" and "new binding"
> 
> ---
> Shawn Guo (8):
>       ASoC: fsl: separate SSI and DMA Kconfig options
>       ASoC: imx: merge sound/soc/imx into sound/soc/fsl
>       ASoC: fsl: rename imx-pcm Kconfig options and filename
>       ASoC: fsl: create fsl_utils to accommodate the common functions
>       ASoC: fsl: remove helper fsl_asoc_get_codec_dev_name
>       ASoC: fsl: make fsl_ssi driver compilable on ARM/IMX
>       ASoC: fsl: let fsl_ssi work with imx pcm and machine drivers
>       ASoC: fsl: add imx-sgtl5000 machine driver

Entire patchset:

Acked-by: Timur Tabi <timur@freescale.com>

-- 
Timur Tabi
Linux kernel developer at Freescale
