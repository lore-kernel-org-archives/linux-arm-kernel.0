From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 7 Aug 2017 16:02:30 -0700
Subject: [PATCH 1/2] clk: fractional-divider: allow overriding of
 approximation
In-Reply-To: <5453089.AIzWDZk3ey@phil>
References: <1500624187-12165-1-git-send-email-zhangqing@rock-chips.com>
 <5990882.df1suBpf8V@phil> <5453089.AIzWDZk3ey@phil>
Message-ID: <20170807230230.GY2146@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/01, Heiko Stuebner wrote:
> From: Elaine Zhang <zhangqing@rock-chips.com>
> 
> Fractional dividers may have special requirements concerning numerator
> and denominator selection that differ from just getting the best
> approximation.
> 
> For example on Rockchip socs the denominator must be at least 20 times
> larger than the numerator to generate precise clock frequencies.
> 
> Therefore add the ability to provide custom approximation functions.
> 
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> ---

Acked-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
