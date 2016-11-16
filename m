From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Wed, 16 Nov 2016 11:05:51 +0100
Subject: [PATCH] cpufreq: dt: Add support for r8a7743 and r8a7745
Message-ID: <1479290751-9705-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the compatible strings for supporting the generic cpufreq driver on
the Renesas RZ/G1M (r8a7743) and RZ/G1E (r8a7745) SoCs.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Support for RZ/G1M and RZ/G1E is expected to land in v4.10.

 drivers/cpufreq/cpufreq-dt-platdev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index fcc5bcfe57efe1c3..0c73c7dbd5878919 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -55,6 +55,8 @@
 	{ .compatible = "renesas,r7s72100", },
 	{ .compatible = "renesas,r8a73a4", },
 	{ .compatible = "renesas,r8a7740", },
+	{ .compatible = "renesas,r8a7743", },
+	{ .compatible = "renesas,r8a7745", },
 	{ .compatible = "renesas,r8a7778", },
 	{ .compatible = "renesas,r8a7779", },
 	{ .compatible = "renesas,r8a7790", },
-- 
1.9.1
