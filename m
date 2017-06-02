From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 2 Jun 2017 15:39:46 -0700
Subject: [PATCH V3 1/3] clk: add clk_bulk_get accessories
In-Reply-To: <1495201746-31841-2-git-send-email-aisheng.dong@nxp.com>
References: <1495201746-31841-1-git-send-email-aisheng.dong@nxp.com>
 <1495201746-31841-2-git-send-email-aisheng.dong@nxp.com>
Message-ID: <20170602223946.GV20170@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/19, Dong Aisheng wrote:
> These helper function allows drivers to get several clk consumers in
> one operation. If any of the clk cannot be acquired then any clks
> that were got will be put before returning to the caller.
> 
> This can relieve the driver owners' life who needs to handle many clocks,
> as well as each clock error reporting.
> 
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@codeaurora.org>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: Anson Huang <anson.huang@nxp.com>
> Cc: Robin Gong <yibin.gong@nxp.com>
> Cc: Bai Ping <ping.bai@nxp.com>
> Cc: Leonard Crestez <leonard.crestez@nxp.com>
> Cc: Octavian Purdila <octavian.purdila@nxp.com>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---

Applied to clk-bulk-get and merged into clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
