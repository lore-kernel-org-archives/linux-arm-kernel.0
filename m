From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 2 Nov 2017 00:19:42 -0700
Subject: [RESEND RFC PATCH 3/7] clk: sunxi: Add CLK_SET_RATE_PARENT flag
 for H3 HDMI clock
In-Reply-To: <20170920200124.20457-4-jernej.skrabec@siol.net>
References: <20170920200124.20457-1-jernej.skrabec@siol.net>
 <20170920200124.20457-4-jernej.skrabec@siol.net>
Message-ID: <20171102071942.GN30645@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/20, Jernej Skrabec wrote:
> When setting the HDMI clock of H3, the PLL_VIDEO clock needs to be set.
> 
> Add CLK_SET_RATE_PARENT flag for H3 HDMI clock.
> 
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---

Acked-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
