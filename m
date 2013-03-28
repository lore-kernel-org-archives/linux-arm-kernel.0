From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 28 Mar 2013 15:40:45 +0800
Subject: [PATCH v2 08/11] ARM i.MX6q: fix ldb di divider and selector
 clocks
In-Reply-To: <1364405445-5271-9-git-send-email-p.zabel@pengutronix.de>
References: <1364405445-5271-1-git-send-email-p.zabel@pengutronix.de>
 <1364405445-5271-9-git-send-email-p.zabel@pengutronix.de>
Message-ID: <20130328074043.GC2756@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 27, 2013 at 06:30:42PM +0100, Philipp Zabel wrote:
> Use imx_clk_mux_flags and imx_clk_divider_flags to set the appropriate
> flags for the LDB display interface divider and selector clocks.
> 
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>

Applied, thanks.
