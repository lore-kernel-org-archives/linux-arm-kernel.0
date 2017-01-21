From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 20 Jan 2017 16:21:50 -0800
Subject: [PATCH] clk: imx6: don't restrict LDB mux changes on QuadPlus
In-Reply-To: <20170113173943.23677-1-l.stach@pengutronix.de>
References: <20170113173943.23677-1-l.stach@pengutronix.de>
Message-ID: <20170121002150.GL20800@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/13, Lucas Stach wrote:
> The LDB mux/gate layout has been fixed on QuadPlus, so there is no need
> to restrict the LDB mux changes on this hardware, as the erratum
> preventing this from working properly is gone.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
