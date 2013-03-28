From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 28 Mar 2013 15:39:48 +0800
Subject: [PATCH v2 06/11] ARM i.MX: Add imx_clk_divider_flags and
 imx_clk_mux_flags
In-Reply-To: <1364405445-5271-7-git-send-email-p.zabel@pengutronix.de>
References: <1364405445-5271-1-git-send-email-p.zabel@pengutronix.de>
 <1364405445-5271-7-git-send-email-p.zabel@pengutronix.de>
Message-ID: <20130328073945.GA2756@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 27, 2013 at 06:30:40PM +0100, Philipp Zabel wrote:
> The default is for dividers to set CLK_SET_PARENT_RATE and for muxes to
> not set that flag. In the LDB clock tree, we need the opposite, so add
> functions to create divider and mux clocks with configurable flags.
> 
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>

Applied, thanks.
