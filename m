From: galak@codeaurora.org (Kumar Gala)
Date: Tue, 17 Sep 2013 10:51:43 -0500
Subject: [PATCH] ARM: msm: Rename msm devicetrees to have standard 'qcom'
 prefix
Message-ID: <1379433103-23995-1-git-send-email-galak@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use a standard 'qcom' prefix to denotate device trees meant for Qualcomm
based processors.

Signed-off-by: Kumar Gala <galak@codeaurora.org>
---
 arch/arm/boot/dts/Makefile                                    | 4 ++--
 arch/arm/boot/dts/{msm8660-surf.dts => qcom-msm8660-surf.dts} | 0
 arch/arm/boot/dts/{msm8960-cdp.dts => qcom-msm8960-cdp.dts}   | 0
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename arch/arm/boot/dts/{msm8660-surf.dts => qcom-msm8660-surf.dts} (100%)
 rename arch/arm/boot/dts/{msm8960-cdp.dts => qcom-msm8960-cdp.dts} (100%)

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index cc0f1fb..b437846 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -101,8 +101,8 @@ dtb-$(CONFIG_ARCH_KIRKWOOD) += kirkwood-cloudbox.dtb \
 	kirkwood-ts219-6282.dtb \
 	kirkwood-openblocks_a6.dtb
 dtb-$(CONFIG_ARCH_MARCO) += marco-evb.dtb
-dtb-$(CONFIG_ARCH_MSM) += msm8660-surf.dtb \
-	msm8960-cdp.dtb
+dtb-$(CONFIG_ARCH_MSM) += qcom-msm8660-surf.dtb \
+	qcom-msm8960-cdp.dtb
 dtb-$(CONFIG_ARCH_MVEBU) += armada-370-db.dtb \
 	armada-370-mirabox.dtb \
 	armada-370-netgear-rn102.dtb \
diff --git a/arch/arm/boot/dts/msm8660-surf.dts b/arch/arm/boot/dts/qcom-msm8660-surf.dts
similarity index 100%
rename from arch/arm/boot/dts/msm8660-surf.dts
rename to arch/arm/boot/dts/qcom-msm8660-surf.dts
diff --git a/arch/arm/boot/dts/msm8960-cdp.dts b/arch/arm/boot/dts/qcom-msm8960-cdp.dts
similarity index 100%
rename from arch/arm/boot/dts/msm8960-cdp.dts
rename to arch/arm/boot/dts/qcom-msm8960-cdp.dts
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
