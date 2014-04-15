From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 15 Apr 2014 11:21:53 +0800
Subject: [PATCH 1/2] ARM: imx6q: clk: Parent DI clocks to video PLL via
 di_pre_sel
In-Reply-To: <1397485240-29163-1-git-send-email-p.zabel@pengutronix.de>
References: <1397485240-29163-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <20140415032149.GA2523@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 14, 2014 at 04:20:39PM +0200, Philipp Zabel wrote:
> From: Sascha Hauer <s.hauer@pengutronix.de>
> 
> Route the video PLL to the display interface clocks via the di_pre_sel
> and di_sel muxes by default.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>

Applied both, thanks.
