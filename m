From: mturquette@linaro.org (Mike Turquette)
Date: Fri, 06 Mar 2015 09:26:19 -0800
Subject: [PATCH] clk: divider: return real rate instead of divider value
In-Reply-To: <54EE651B.1030105@codeaurora.org>
References: <2011929.fOsbjMkSp9@diego> <54EE651B.1030105@codeaurora.org>
Message-ID: <20150306172619.11109.21447@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Stephen Boyd (2015-02-25 16:13:15)
> On 02/24/15 02:39, Heiko St?bner wrote:
> > Commit bca9690b9426 ("clk: divider: Make generic for usage elsewhere")
> > returned only the divider value for read-only dividers instead of the
> > actual rate.
> >
> > Fixes: bca9690b9426 ("clk: divider: Make generic for usage elsewhere")
> > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> >
> 
> Oops. Thanks.
> 
> Acked-by: Stephen Boyd <sboyd@codeaurora.org>

Applied to clk-fixes.

Regards,
Mike

> 
> -- 
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
