From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 25 Feb 2015 14:09:51 -0800
Subject: [PATCH v5 1/6] clk: add of_clk_get_parent_rate function
In-Reply-To: <1423097705-22939-2-git-send-email-rjui@broadcom.com>
References: <Ray Jui <rjui@broadcom.com>
 <1423097705-22939-1-git-send-email-rjui@broadcom.com>
 <1423097705-22939-2-git-send-email-rjui@broadcom.com>
Message-ID: <54EE482F.4010402@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/04/15 16:55, Ray Jui wrote:
> Sometimes a clock needs to know the rate of its parent before itself is
> registered to the framework. An example is that a PLL may need to
> initialize itself to a specific VCO frequency, before registering to the
> framework. The parent rate needs to be known, for PLL multipliers and
> divisors to be configured properly.
>
> Introduce helper function of_clk_get_parent_rate, which can be used to
> obtain the parent rate of a clock, given a device node and index.
>
> Signed-off-by: Ray Jui <rjui@broadcom.com>

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
