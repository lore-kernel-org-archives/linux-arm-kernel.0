From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 24 Oct 2017 01:36:28 -0700
Subject: [PATCH] clk: sunxi: fix build warning
In-Reply-To: <20171020072904.kfmx65lbqd3uw2qh@flea>
References: <20171019190948.5754-1-clabbe.montjoie@gmail.com>
 <20171020072904.kfmx65lbqd3uw2qh@flea>
Message-ID: <20171024083628.GC15990@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/20, Maxime Ripard wrote:
> Hi Stephen, Mike,
> 
> On Thu, Oct 19, 2017 at 09:09:48PM +0200, Corentin Labbe wrote:
> > This patch fix the following build warning:
> > drivers/clk/sunxi/clk-factors.c:279:14: warning: variable 'name' set but not used [-Wunused-but-set-variable]
> > 
> > Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
> 
> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> 
> Can you apply that patch directly? This is the only fix that we're
> supposed to have for 4.14.
> 

Fixes tag? And this is a new warning from the v4.14 merge window?
I suppose it only removes code so that's a plus side for merging
into fixes.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
