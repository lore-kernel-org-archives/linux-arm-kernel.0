From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 11 Aug 2015 11:34:25 -0700
Subject: [GIT PULL] i.MX clock updates for 4.2
In-Reply-To: <20150811174657.2416.1270@quantum>
References: <20150811085921.GB10035@tiger> <20150811174657.2416.1270@quantum>
Message-ID: <20150811183425.GL2839@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/11, Michael Turquette wrote:
> > 
> > Also, please keep it stable, because I need to pull it into other
> > branch as dependency which I will send via arm-soc tree.
> 
> Will do.
> 
> Also, the clock driver was not Cc'd to linux-clk mailing list nor did it
> Cc myself or Stephen. I've taken a quick look at it and it seems fine,
> but please post clk patches to the linux-clk mailing list in the future.
> 

Yes. We would have found this unused include too. I'll apply this
after we merge it into clk-next.

----8<----
From: Stephen Boyd <sboyd@codeaurora.org>
Subject: [PATCH] clk: imx: Remove unused clkdev.h include

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/clk/imx/clk-imx6ul.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/clk/imx/clk-imx6ul.c b/drivers/clk/imx/clk-imx6ul.c
index aaa36650695f..c498f558e942 100644
--- a/drivers/clk/imx/clk-imx6ul.c
+++ b/drivers/clk/imx/clk-imx6ul.c
@@ -11,7 +11,6 @@
 
 #include <dt-bindings/clock/imx6ul-clock.h>
 #include <linux/clk.h>
-#include <linux/clkdev.h>
 #include <linux/err.h>
 #include <linux/init.h>
 #include <linux/io.h>
-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
