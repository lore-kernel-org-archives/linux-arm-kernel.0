From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 20 Jan 2017 16:23:50 -0800
Subject: [PATCH v2 3/3] clk: bcm2835: Add leaf clock measurement support,
 disabled by default
In-Reply-To: <20170117203157.23822-3-eric@anholt.net>
References: <20170117203157.23822-1-eric@anholt.net>
 <20170117203157.23822-3-eric@anholt.net>
Message-ID: <20170121002350.GO20800@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/18, Eric Anholt wrote:
> This proved incredibly useful during debugging of the DSI driver, to
> see if our clocks were running at rate we requested.  Let's leave it
> here for the next person interacting with clocks on the platform (and
> so that hopefully we can just hook it up to debugfs some day).
> 
> Signed-off-by: Eric Anholt <eric@anholt.net>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
