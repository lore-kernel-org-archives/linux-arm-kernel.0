From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 15 Apr 2016 15:34:41 -0700
Subject: [PATCH v3 03/19] clk: sunxi: Add PLL3 clock
In-Reply-To: <1458751122-23976-4-git-send-email-maxime.ripard@free-electrons.com>
References: <1458751122-23976-1-git-send-email-maxime.ripard@free-electrons.com>
 <1458751122-23976-4-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20160415223441.GT14441@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/23, Maxime Ripard wrote:
> The A10 SoCs and relatives have a PLL controller to drive the PLL3 and
> PLL7, clocked from a 3MHz oscillator, that drives the display related
> clocks (GPU, display engine, TCON, etc.)
> 
> Add a driver for it.
> 
> Acked-by: Rob Herring <robh@kernel.org>
> Acked-by: Chen-Yu Tsai <wens@csie.org>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---

Acked-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
