From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 06 Jul 2015 16:57:18 -0700
Subject: [PATCH] amba: Support clk parents and rates assigned in DT
In-Reply-To: <1432846332-17692-1-git-send-email-sboyd@codeaurora.org>
References: <1432846332-17692-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <559B15DE.7040200@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/28/2015 01:52 PM, Stephen Boyd wrote:
> Add the call to of_clk_set_defaults() into the amba probe path so
> that devices on the amba bus can use the assigned rates and
> parents feature of the common clock framework.
>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---

Shall I put this into the patch tracker? Turns out it wasn't needed for
the hisi stuff immediately.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
