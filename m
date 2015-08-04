From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 03 Aug 2015 18:14:17 -0700
Subject: [PATCH v2 1/2] clk: rockchip: add pclk_pd_pmu to the list of
 rk3288 critical clocks
In-Reply-To: <1438650222-14357-1-git-send-email-hl@rock-chips.com>
References: <1438650222-14357-1-git-send-email-hl@rock-chips.com>
Message-ID: <55C011E9.3000002@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/03/2015 06:03 PM, Lin Huang wrote:
> From: huang lin <hl@rock-chips.com>
>
> pclk_pd_pmu needs to keep running and with the upcoming gpio clock
> handling this is not always the case anymore. So add it to the list
> of critical clocks for now.
>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> Signed-off-by: Lin Huang <hl@rock-chips.com>

From: says huang lin, first signed-off-by is Heiko Stuebner, and final 
signed-off-by is Lin Huang... who actually authored this patch? Is Lin 
Huang the same person as huang lin ?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
