From: shawn.guo@linaro.org (Shawn Guo)
Date: Sat, 21 Jul 2012 15:20:30 +0800
Subject: [alsa-devel] [PATCH 2/4] ASoC: mxs-saif: set a base clock rate
 for EXTMASTER mode work
In-Reply-To: <1342776027-31758-3-git-send-email-b29396@freescale.com>
References: <1342776027-31758-1-git-send-email-b29396@freescale.com>
 <1342776027-31758-3-git-send-email-b29396@freescale.com>
Message-ID: <20120721072028.GB923@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 20, 2012 at 05:20:25PM +0800, Dong Aisheng wrote:
> From: Dong Aisheng <dong.aisheng@linaro.org>
> 
> Set an initial clock rate for the saif internal logic to work
> properly. This is important when working in EXTMASTER mode that
> uses the other saif's BITCLK&LRCLK but it still needs a basic
> clock which should be fast enough for the internal logic.
> 
> Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
> Cc: Liam Girdwood <lrg@ti.com>
> Cc: Wolfram Sang <w.sang@pengutronix.de>
> Cc: Shawn Guo <shawn.guo@linaro.org>

Acked-by: Shawn Guo <shawn.guo@linaro.org>
