From: fabio.baltieri@linaro.org (Fabio Baltieri)
Date: Thu, 30 May 2013 15:27:41 +0200
Subject: [PATCH 1/5] ARM: ux500: Fix trivial typo in v-anamic1 comment
In-Reply-To: <1369920465-13905-1-git-send-email-fabio.baltieri@linaro.org>
References: <1369920465-13905-1-git-send-email-fabio.baltieri@linaro.org>
Message-ID: <1369920465-13905-2-git-send-email-fabio.baltieri@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix VAMIC1 LDO comment in DT files to be make it coherent with the
others.

Signed-off-by: Fabio Baltieri <fabio.baltieri@linaro.org>
---
 arch/arm/boot/dts/dbx5x0.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/dbx5x0.dtsi b/arch/arm/boot/dts/dbx5x0.dtsi
index b6bc4ff..e6ea7ba 100644
--- a/arch/arm/boot/dts/dbx5x0.dtsi
+++ b/arch/arm/boot/dts/dbx5x0.dtsi
@@ -460,7 +460,7 @@
 						regulator-compatible = "ab8500_ldo_audio";
 					};
 
-					// supply for v-anamic1 VAMic1-LDO
+					// supply for v-anamic1 VAMIC1 LDO
 					ab8500_ldo_anamic1_reg: ab8500_ldo_anamic1 {
 						regulator-compatible = "ab8500_ldo_anamic1";
 					};
-- 
1.8.2
