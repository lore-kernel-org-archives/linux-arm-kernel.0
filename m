From: simon.guinot@sequanux.org (Simon Guinot)
Date: Wed,  2 Oct 2013 17:56:58 +0200
Subject: [PATCH] clk: armada-370: fix tclk frequencies
Message-ID: <1380729418-14393-1-git-send-email-simon.guinot@sequanux.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Simon Guinot <simon.guinot@sequanux.org>
---
 drivers/clk/mvebu/armada-370.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/mvebu/armada-370.c b/drivers/clk/mvebu/armada-370.c
index fc777bd..81a202d 100644
--- a/drivers/clk/mvebu/armada-370.c
+++ b/drivers/clk/mvebu/armada-370.c
@@ -39,8 +39,8 @@ static const struct coreclk_ratio a370_coreclk_ratios[] __initconst = {
 };
 
 static const u32 a370_tclk_freqs[] __initconst = {
-	16600000,
-	20000000,
+	166000000,
+	200000000,
 };
 
 static u32 __init a370_get_tclk_freq(void __iomem *sar)
-- 
1.7.10.4
