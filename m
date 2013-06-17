From: davidb@codeaurora.org (David Brown)
Date: Mon, 17 Jun 2013 13:39:38 -0700
Subject: [PATCH] ARM: dts: msm: Fix merge resolution
Message-ID: <1371501578-24484-1-git-send-email-davidb@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit e45600107b (Merge tag 'msm-cleanup-for-3.11' of
git://git.kernel.org/pub/scm/linux/kernel/git/davidb/linux-msm into
next/cleanup) incorrectly resolved a merge conflict, resulting in a
node address that doesn't match the register address.

Fix this node address.

Signed-off-by: David Brown <davidb@codeaurora.org>
Cc: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm/boot/dts/msm8960-cdp.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/msm8960-cdp.dts b/arch/arm/boot/dts/msm8960-cdp.dts
index e9eb835..db2060c 100644
--- a/arch/arm/boot/dts/msm8960-cdp.dts
+++ b/arch/arm/boot/dts/msm8960-cdp.dts
@@ -37,7 +37,7 @@
 		reg = <0xfd510000 0x4000>;
 	};
 
-	serial at 19440000 {
+	serial at 16440000 {
 		compatible = "qcom,msm-hsuart", "qcom,msm-uart";
 		reg = <0x16440000 0x1000>,
 		      <0x16400000 0x1000>;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
