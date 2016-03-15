From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 15 Mar 2016 11:45:35 -0700
Subject: [PATCH v2 8/9] clk: rockchip: associate SCLK_MAC_PLL and disable
 reparenting on rk3036
In-Reply-To: <1457860062-5514-9-git-send-email-wxt@rock-chips.com>
References: <1457860062-5514-1-git-send-email-wxt@rock-chips.com>
 <1457860062-5514-9-git-send-email-wxt@rock-chips.com>
Message-ID: <20160315184535.GG25972@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/13, Caesar Wang wrote:
> From: Heiko Stuebner <heiko@sntech.de>
> 
> The emac needs constant and very specific rate but the possible PLL-sources
> are very limited, so we expect the PLL source to be set manually on per
> board and don't want it to get changed in an automatic way later.
> So add the necessary clock-id and disable reparenting on set_rate calls.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> Signed-off-by: Caesar Wang <wxt@rock-chips.com>
> ---

Acked-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
