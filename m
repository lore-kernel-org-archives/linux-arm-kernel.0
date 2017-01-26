From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 26 Jan 2017 15:44:21 -0800
Subject: [PATCH] clk: gxbb: fix CLKID_ETH defined twice
In-Reply-To: <1485446749-12679-1-git-send-email-jbrunet@baylibre.com>
References: <1485446749-12679-1-git-send-email-jbrunet@baylibre.com>
Message-ID: <20170126234421.GG8801@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/26, Jerome Brunet wrote:
> CLKID_ETH is define in the dt-bindings but has not be commented out in the
> clock driver. Just do it now.
> 
> Fixes: 738f66d3211d ("clk: gxbb: add AmLogic GXBB clk controller driver")
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---

Acked-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
