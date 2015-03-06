From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 06 Mar 2015 11:44:05 -0800
Subject: [PATCH 0/3] clk: divider: three exactness fixes (and a rant)
In-Reply-To: <20150306185730.11109.45998@quantum>
References: <20150221085620.GV19388@pengutronix.de>
 <1424515225-6929-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20150306185730.11109.45998@quantum>
Message-ID: <54FA0385.2060808@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/06/15 10:57, Mike Turquette wrote:
>
> Uwe,
>
> Thanks for the fixes. I'm thinking of taking all three for 4.0. I also
> agree on clk_round_rate_nearest (along with a _ceil and _floor version
> as well). That's something we can do for 4.1 probably.
>
> There are currently 3 users of CLK_DIVIDER_ROUND_CLOSEST:
>
> Loongson
> QCOM
> ST
>
> So now is probably the right time to remove the flag if we're going to
> do it.
>
> What do you think?
>

I may have had to do divider round closest on qcom platforms because of
the problem these patches are for. I'll have to go back and look.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
