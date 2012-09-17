From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 17 Sep 2012 07:46:40 -0400
Subject: [PATCH 33/34] ARM: imx: remove header file mach/irqs.h
In-Reply-To: <1347860103-4141-34-git-send-email-shawn.guo@linaro.org>
References: <1347860103-4141-1-git-send-email-shawn.guo@linaro.org>
 <1347860103-4141-34-git-send-email-shawn.guo@linaro.org>
Message-ID: <20120917114640.GH5401@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 17, 2012 at 01:35:02PM +0800, Shawn Guo wrote:
> The only mach/irqs.h user outside arch/arm/mach-imx is
> sound/soc/fsl/imx-pcm-fiq.c, which refers to mxc_set_irq_fiq().
> Though moving the declaration into imx-pcm-fiq.c will result in
> the checkpatch below, let's do it to gain the multi-platform support
> for mach-imx.

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
