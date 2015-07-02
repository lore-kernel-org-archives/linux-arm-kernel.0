From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 2 Jul 2015 10:00:09 -0700
Subject: [PATCH 6/9] drivers: clk: st: Add CLK_GET_RATE_NOCACHE flag to
 clocks
In-Reply-To: <1435068567-30995-7-git-send-email-gabriel.fernandez@linaro.org>
References: <1435068567-30995-1-git-send-email-gabriel.fernandez@linaro.org>
 <1435068567-30995-7-git-send-email-gabriel.fernandez@linaro.org>
Message-ID: <20150702170009.GD4301@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/23, Gabriel Fernandez wrote:
> From: Pankaj Dev <pankaj.dev@st.com>
> 
> Add the CLK_GET_RATE_NOCACHE flag to all the clocks with recalc ops,
> so that they reflect Hw rate after CPS wake-up when a clk_get_rate()
> is called
> 
> Signed-off-by: Pankaj Dev <pankaj.dev@st.com>
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@linaro.org>
> ---

Applied to clk-fixes

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
