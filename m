From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 19 Jun 2017 18:02:58 -0700
Subject: [PATCH] clk: zx296718: export I2S mux clocks
In-Reply-To: <1497709265-22944-1-git-send-email-shawnguo@kernel.org>
References: <1497709265-22944-1-git-send-email-shawnguo@kernel.org>
Message-ID: <20170620010258.GJ20170@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/17, Shawn Guo wrote:
> From: Shawn Guo <shawn.guo@linaro.org>
> 
> Export I2S mux clocks, so that device tree can refer to them for setting
> a better parent clock for I2S work clock.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
