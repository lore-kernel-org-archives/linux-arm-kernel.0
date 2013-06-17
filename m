From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 17 Jun 2013 10:36:57 +0800
Subject: [PATCH v8 00/11] ASoC: fsl-ssi: ac97-slave support
In-Reply-To: <1371389117-19729-1-git-send-email-mpa@pengutronix.de>
References: <1371389117-19729-1-git-send-email-mpa@pengutronix.de>
Message-ID: <20130617023656.GE31687@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 16, 2013 at 03:25:06PM +0200, Markus Pargmann wrote:
> Markus Pargmann (11):
>       ASoC: imx-pcm-dma: DT support
>       ASoC: imx-pcm-fiq: Introduce pcm-fiq-params
>       ASoC: fsl: Move soc_ac97_ops from imx-ssi to fsl_ssi
>       ASoC: fsl-ssi: Add support for imx-pcm-fiq
>       ASoC: fsl-ssi: Use generic DMA bindings if possible
>       ASoC: fsl-ssi: imx ac97 support
>       ARM: imx: Export ac97 reset functions
>       ASoC: Add phycore-ac97-dt driver
>       ASoC: fsl: Kconfig: Use fsl-ssi for phycore-ac97
>       ASoC: fsl: Move fsl-ssi binding doc to sound/
>       ASoC: fsl: Update fsl-ssi binding doc

Tested-by: Shawn Guo <shawn.guo@linaro.org>
