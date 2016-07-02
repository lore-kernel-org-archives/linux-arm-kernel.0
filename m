From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 1 Jul 2016 17:17:08 -0700
Subject: [PATCH 1/2] clk: fixed-factor: Allow for a few clocks to change
 the parent rate
In-Reply-To: <20160622091555.18415-1-maxime.ripard@free-electrons.com>
References: <20160622091555.18415-1-maxime.ripard@free-electrons.com>
Message-ID: <20160702001708.GE27880@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/22, Maxime Ripard wrote:
> The only way for a fixed factor clock to change its rate would be to change
> its parent rate.
> 
> Since passing blindly CLK_SET_RATE_PARENT might break a lot of platforms
> that were relying on the fact that the parent rate wouldn't change,
> introduce a compatible-based whitelist that will allow clocks to opt-in
> that flag.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
