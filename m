From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 10 Nov 2017 18:49:23 -0800
Subject: [PATCH] clk: hi3798cv200: correct parent mux clock for
 'clk_sdio0_ciu'
In-Reply-To: <1506538780-15513-1-git-send-email-shawnguo@kernel.org>
References: <1506538780-15513-1-git-send-email-shawnguo@kernel.org>
Message-ID: <20171111024923.GF22441@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/27, Shawn Guo wrote:
> From: Shawn Guo <shawn.guo@linaro.org>
> 
> Other than 'mmc_mux', 'clk_sdio0_ciu' uses a different parent mux clock.
> Let's add this mux clock as 'sdio0_mux', and correct the parent of
> 'clk_sdio0_ciu' to be it.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
