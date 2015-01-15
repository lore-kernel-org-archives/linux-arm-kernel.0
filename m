From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 15 Jan 2015 11:47:06 +0100
Subject: [PATCH v3 5/5] ARM: mvebu: enable Armada 38x RTC driver in
 mvebu_v7_defconfig
In-Reply-To: <1421318826-27268-1-git-send-email-gregory.clement@free-electrons.com>
References: <1421318826-27268-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1421318826-27268-6-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that the Armada 38x RTC driver has been pushed, let's enable it in
mvebu_v7_defconfig.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/configs/mvebu_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/mvebu_v7_defconfig b/arch/arm/configs/mvebu_v7_defconfig
index 627accea72fb..2400b9f52403 100644
--- a/arch/arm/configs/mvebu_v7_defconfig
+++ b/arch/arm/configs/mvebu_v7_defconfig
@@ -112,6 +112,7 @@ CONFIG_LEDS_TRIGGER_HEARTBEAT=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_S35390A=y
 CONFIG_RTC_DRV_MV=y
+CONFIG_RTC_DRV_ARMADA38X=y
 CONFIG_DMADEVICES=y
 CONFIG_MV_XOR=y
 # CONFIG_IOMMU_SUPPORT is not set
-- 
1.9.1
