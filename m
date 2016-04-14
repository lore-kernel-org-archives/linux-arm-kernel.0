From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 13 Apr 2016 17:43:31 -0700
Subject: [PATCH v1] clk: Add clk_composite_set_rate_and_parent
In-Reply-To: <3986787.PS6VzOpSAJ@phil>
References: <1460339652-63498-1-git-send-email-finley.xiao@rock-chips.com>
 <3986787.PS6VzOpSAJ@phil>
Message-ID: <20160414004331.GK14441@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/12, Heiko Stuebner wrote:
> 
> I remember having clocks not overflow their target rate came up in some ELC 
> talk last week (probably in Stephens Qualcomm-kernel-talk) and a general 
> solution might need some changes closer to the core.

Yep. It's on the list. Hopefully coordinated clk rate changes
will help here. Composite clks are sort of already coordinated
rates in a minor form though.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
