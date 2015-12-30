From: cov@codeaurora.org (Christopher Covington)
Date: Wed, 30 Dec 2015 14:35:08 -0500
Subject: [PATCH] arm64: defconfig: Enable PL031
Message-ID: <1451504108-5245-1-git-send-email-cov@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since Real Time Clock (RTC) configuration options were first enabled in the
arm64 defconfig (commit 2d39ad6 "arm64: defconfig: update defconfig for
3.18"), QEMU's device tree based virt machine has grown to include a PL031
RTC. Update the defconfig accordingly.

Signed-off-by: Christopher Covington <cov@codeaurora.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index bdd7aa3..9bd25e0 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -168,6 +168,7 @@ CONFIG_LEDS_TRIGGER_HEARTBEAT=y
 CONFIG_LEDS_TRIGGER_CPU=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_EFI=y
+CONFIG_RTC_DRV_PL031=y
 CONFIG_RTC_DRV_XGENE=y
 CONFIG_DMADEVICES=y
 CONFIG_QCOM_BAM_DMA=y
-- 
Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
