From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 20 Apr 2016 11:40:03 -0700
Subject: [PATCH] ARM: mv78xx0: Remove CLK_IS_ROOT
In-Reply-To: <9103114.2LquUEkh1k@wuerfel>
References: <1461116404-3285-1-git-send-email-sboyd@codeaurora.org>
 <9103114.2LquUEkh1k@wuerfel>
Message-ID: <20160420184003.GI15324@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/20, Arnd Bergmann wrote:
> On Tuesday 19 April 2016 18:40:04 Stephen Boyd wrote:
> > This flag is a no-op now (see commit 47b0eeb3dc8a "clk: Deprecate
> > CLK_IS_ROOT", 2016-02-02) so remove it.
> > 
> > Cc: Andrew Lunn <andrew@lunn.ch>
> > Cc: Jason Cooper <jason@lakedaemon.net
> > Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> > 
> 
> Looks good, like all other instances in arch/arm.
> 
> If you want to merge these through your tree, please add my
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> 
> to all of them, in addition to the other other Acks. I don't
> think there is a significant risk for regressions as they all
> tend to be "stable" in the sense that those files haven't
> been touched in a while.
> 

Thanks. If Gregory doesn't pick them up I'll take care of it, but
we're not in any hurry here.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
