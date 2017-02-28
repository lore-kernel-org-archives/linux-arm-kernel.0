From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 27 Feb 2017 23:33:06 -0800
Subject: [PATCH 1/4] clk: rockchip: add "," to
 mux_pll_src_apll_dpll_gpll_usb480m_p on rk3036
In-Reply-To: <20170228051420.7214-2-heiko@sntech.de>
References: <20170228051420.7214-1-heiko@sntech.de>
 <20170228051420.7214-2-heiko@sntech.de>
Message-ID: <20170228073306.GK25384@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/28, Heiko Stuebner wrote:
> The mux_pll_src_apll_dpll_gpll_usb480m_p parent list was missing a ","
> between the 3rd and 4th parent names, making them fall together and thus
> lookups fail. Fix that.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---

Subtle. Fixes tag?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
