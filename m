From: shawn.guo@freescale.com (Shawn Guo)
Date: Fri, 20 Jun 2014 15:58:14 +0800
Subject: [PATCH 1/2] ARM: dts: imx6: remove wrong spdif rxtx2 clock
In-Reply-To: <1402875585-29025-1-git-send-email-anssi.hannula@iki.fi>
References: <1402875585-29025-1-git-send-email-anssi.hannula@iki.fi>
Message-ID: <20140620075812.GD28225@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 16, 2014 at 02:39:44AM +0300, Anssi Hannula wrote:
> The rxtx2 clock of i.MX6 S/PDIF is currently set to "asrc" clock.
> However, according to SoC documentation, rxtx2 is connected to
> ASRC_EXT_CLK, a different external clock.
> 
> Testing on Cubox-i system seems to confirm that: when fsl_spdif is
> forced to select rxtx2 as input clock, audio playback fails with an I/O
> error.
> 
> Set rxtx2 to the dummy clock by default to prevent fsl_spdif from
> selecting it.
> 
> Signed-off-by: Anssi Hannula <anssi.hannula@iki.fi>
> Cc: Nicolin Chen <Guangyu.Chen@freescale.com>
> Cc: Mark Brown <broonie@kernel.org>

Applied both, thanks.
