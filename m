From: philippe.retornaz@epfl.ch (Philippe =?ISO-8859-1?Q?R=E9tornaz?=)
Date: Tue, 27 Mar 2012 17:06:36 +0200
Subject: [PATCH v5 2/8] ASoC: imx: merge sound/soc/imx into sound/soc/fsl
In-Reply-To: <1331888204-27058-3-git-send-email-shawn.guo@linaro.org>
References: <1331888204-27058-1-git-send-email-shawn.guo@linaro.org>
 <1331888204-27058-3-git-send-email-shawn.guo@linaro.org>
Message-ID: <2976261.6mYHfHvpym@laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le vendredi 16 mars 2012 16:56:38 Shawn Guo a ?crit :
> Freescale PowerPC and ARM/IMX families share the same SSI IP block.
> The patch merges sound/soc/imx into sound/soc/fsl, so that the possible
> code sharing and consolidation can happen.
> 
> This is a plain merge, except that menuconfig SND_POWERPC_SOC is added
> in Kconfig for PowerPC platform as a correspondence to SND_IMX_SOC for
> IMX platform.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> Acked-by: Sascha Hauer <s.hauer@pengutronix.de>

This patch has been merged ? If yes in which tree is it available ? 

Thanks,

Philippe
