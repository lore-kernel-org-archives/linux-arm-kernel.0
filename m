From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 17 Oct 2016 15:34:38 -0700
Subject: [PATCH v2] clk: bcm2835: Clamp the PLL's requested rate to the
 hardware limits.
In-Reply-To: <20160930170727.32544-1-eric@anholt.net>
References: <20160930170727.32544-1-eric@anholt.net>
Message-ID: <20161017223438.GK8871@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/30, Eric Anholt wrote:
> Fixes setting low-resolution video modes on HDMI.  Now the PLLH_PIX
> divider adjusts itself until the PLLH is within bounds.
> 
> Signed-off-by: Eric Anholt <eric@anholt.net>
> ---

Applied to clk-fixes

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
