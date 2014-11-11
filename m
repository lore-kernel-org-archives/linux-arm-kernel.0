From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 11 Nov 2014 22:53:18 +0800
Subject: [PATCH v2] ARM: dts: imx6qdl-sabresd: Fix the microphone route
In-Reply-To: <1415369281-7367-1-git-send-email-festevam@gmail.com>
References: <1415369281-7367-1-git-send-email-festevam@gmail.com>
Message-ID: <20141111145316.GI2704@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 07, 2014 at 12:08:01PM -0200, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Since commit e409dfbfccf9a49 ("ASoC: dapm: Add a few supply widget sanity 
> checks") the following error is seen:
> 
> imx-wm8962 sound: wm8962 <-> 202c000.ssi mapping ok
> imx-wm8962 sound: Connecting non-supply widget to supply widget is not supported (AMIC -> MICBIAS)
> imx-wm8962 sound: ASoC: no dapm match for AMIC --> (null) --> MICBIAS
> imx-wm8962 sound: ASoC: Failed to add route AMIC -> direct -> MICBIAS
> 
> Invert the route between the microphone and the bias in order to fix it.
> 
> While at it, align the audio routing with imx6sl-evk and imx6sx-sdb, which have 
> the same wm8962 circuitry.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Applied, thanks.
