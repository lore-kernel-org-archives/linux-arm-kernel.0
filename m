From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 17 Apr 2013 22:13:47 +0800
Subject: [PATCH v2] ARM i.MX6q: Fix periph_clk2_sel and periph2_clk2_sel
 clocks
In-Reply-To: <1366193158-10098-1-git-send-email-p.zabel@pengutronix.de>
References: <1366193158-10098-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <20130417141346.GB20563@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 17, 2013 at 12:05:58PM +0200, Philipp Zabel wrote:
> The periph_clk2_sel mux can be set to pll3, osc/pll1_ref_clk, or osc/
> pll2_burn_in_clk. The periph2_clk2_sel mux can be set to pll3 or pll2.
> 
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>

Applied, thanks.
