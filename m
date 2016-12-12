From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 12 Dec 2016 11:26:49 -0800
Subject: [PATCH] clk: bcm: Fix 'maybe-uninitialized' warning in
 bcm2835_clock_choose_div_and_prate()
In-Reply-To: <1481529653-28133-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1481529653-28133-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20161212192649.GK5423@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/12, Boris Brezillon wrote:
> best_rate is reported as potentially uninitialized by gcc.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> Fixes: 155e8b3b0ee3 ("clk: bcm: Support rate change propagation on bcm2835 clocks")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
