From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 11 Aug 2015 16:01:43 -0700
Subject: [PATCH v5 1/2] clk: rockchip: add pclk_pd_pmu to the list of
 rk3288 critical clocks
In-Reply-To: <1439287924-6988-1-git-send-email-hl@rock-chips.com>
References: <1439287924-6988-1-git-send-email-hl@rock-chips.com>
Message-ID: <55CA7ED7.90003@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/11/2015 03:12 AM, Lin Huang wrote:
> From: Heiko Stuebner <heiko@sntech.de>
>
> pclk_pd_pmu needs to keep running and with the upcoming gpio clock
> handling this is not always the case anymore. So add it to the list
> of critical clocks for now.
>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> Signed-off-by: Lin Huang <hl@rock-chips.com>
> ---
>

Acked-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
