From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 20 Jan 2017 16:23:48 -0800
Subject: [PATCH v2 2/3] clk: bcm2835: Register the DSI0/DSI1 pixel clocks.
In-Reply-To: <20170117203157.23822-2-eric@anholt.net>
References: <20170117203157.23822-1-eric@anholt.net>
 <20170117203157.23822-2-eric@anholt.net>
Message-ID: <20170121002348.GN20800@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/18, Eric Anholt wrote:
> The DSI pixel clocks are muxed from clocks generated in the analog phy
> by the DSI driver.  In order to set them as parents, we need to do the
> same name lookup dance on them as we do for our root oscillator.
> 
> Signed-off-by: Eric Anholt <eric@anholt.net>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
