From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 25 Feb 2015 16:13:15 -0800
Subject: [PATCH] clk: divider: return real rate instead of divider value
In-Reply-To: <2011929.fOsbjMkSp9@diego>
References: <2011929.fOsbjMkSp9@diego>
Message-ID: <54EE651B.1030105@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/24/15 02:39, Heiko St?bner wrote:
> Commit bca9690b9426 ("clk: divider: Make generic for usage elsewhere")
> returned only the divider value for read-only dividers instead of the
> actual rate.
>
> Fixes: bca9690b9426 ("clk: divider: Make generic for usage elsewhere")
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
>

Oops. Thanks.

Acked-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
