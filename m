From: lifshitz@compulab.co.il (Dmitry Lifshitz)
Date: Thu,  4 Sep 2014 16:02:53 +0300
Subject: [PATCH 2/2] ARM: dts: sbc-t54: fix model property
In-Reply-To: <1409835773-22782-1-git-send-email-lifshitz@compulab.co.il>
References: <1409835773-22782-1-git-send-email-lifshitz@compulab.co.il>
Message-ID: <1409835773-22782-3-git-send-email-lifshitz@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CM-T54 CoM can be used with various custom baseboards, other
than SB-T54 (supplied with SBC-T54 single board computer).

Update model property of SBC-T54 DT to clarify this.

Signed-off-by: Dmitry Lifshitz <lifshitz@compulab.co.il>
---
 arch/arm/boot/dts/omap5-sbc-t54.dts |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/omap5-sbc-t54.dts b/arch/arm/boot/dts/omap5-sbc-t54.dts
index aa98fea..8e89793 100644
--- a/arch/arm/boot/dts/omap5-sbc-t54.dts
+++ b/arch/arm/boot/dts/omap5-sbc-t54.dts
@@ -1,11 +1,11 @@
 /*
- * Suppport for CompuLab SBC-T54 with CM-T54
+ * Suppport for CompuLab CM-T54 on SB-T54 baseboard
  */
 
 #include "omap5-cm-t54.dts"
 
 / {
-	model = "CompuLab SBC-T54 with CM-T54";
+	model = "CompuLab CM-T54 on SB-T54";
 	compatible = "compulab,omap5-sbc-t54", "compulab,omap5-cm-t54", "ti,omap5";
 };
 
-- 
1.7.5.4
