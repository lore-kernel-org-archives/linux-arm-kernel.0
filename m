From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 31 Aug 2017 11:31:38 -0700
Subject: [PATCH] clk: imx51: propagate rate across ipu_di*_sel
In-Reply-To: <20170818163058.22252-1-l.stach@pengutronix.de>
References: <20170818163058.22252-1-l.stach@pengutronix.de>
Message-ID: <20170831183138.GG21656@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/18, Lucas Stach wrote:
> This propagates rate requests from the display interface to the divider
> or PLL output, allowing to hit the required display rate in many more
> cases.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
