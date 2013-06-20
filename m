From: mpa@pengutronix.de (Markus Pargmann)
Date: Thu, 20 Jun 2013 14:53:27 +0200
Subject: [PATCH v8 00/11] ASoC: fsl-ssi: ac97-slave support
In-Reply-To: <20130617023656.GE31687@S2101-09.ap.freescale.net>
References: <1371389117-19729-1-git-send-email-mpa@pengutronix.de>
 <20130617023656.GE31687@S2101-09.ap.freescale.net>
Message-ID: <20130620125327.GD3085@s25.your-server.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 17, 2013 at 10:36:57AM +0800, Shawn Guo wrote:
> On Sun, Jun 16, 2013 at 03:25:06PM +0200, Markus Pargmann wrote:
> > Markus Pargmann (11):
> >       ASoC: imx-pcm-dma: DT support
> >       ASoC: imx-pcm-fiq: Introduce pcm-fiq-params
> >       ASoC: fsl: Move soc_ac97_ops from imx-ssi to fsl_ssi
> >       ASoC: fsl-ssi: Add support for imx-pcm-fiq
> >       ASoC: fsl-ssi: Use generic DMA bindings if possible
> >       ASoC: fsl-ssi: imx ac97 support
> >       ARM: imx: Export ac97 reset functions
> >       ASoC: Add phycore-ac97-dt driver
> >       ASoC: fsl: Kconfig: Use fsl-ssi for phycore-ac97
> >       ASoC: fsl: Move fsl-ssi binding doc to sound/
> >       ASoC: fsl: Update fsl-ssi binding doc
> 
> Tested-by: Shawn Guo <shawn.guo@linaro.org>
> 
> 

Thank you for testing.

Regards,

Markus
