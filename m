From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 12 Dec 2012 10:06:26 +0100
Subject: [PATCH V2 4/4] arm: mvebu: Update defconfig with Marvell RTC support
In-Reply-To: <1355303186-9267-1-git-send-email-gregory.clement@free-electrons.com>
References: <1355303186-9267-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1355303186-9267-5-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The RTC class driver is already part of the mvebu_defconfig but the
Marvell internal RTC not yet. Now that its support is added for mvebu
let's update the config file.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/configs/mvebu_defconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/mvebu_defconfig b/arch/arm/configs/mvebu_defconfig
index a702fb3..87a5bed 100644
--- a/arch/arm/configs/mvebu_defconfig
+++ b/arch/arm/configs/mvebu_defconfig
@@ -41,6 +41,7 @@ CONFIG_GPIO_SYSFS=y
 # CONFIG_USB_SUPPORT is not set
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_S35390A=y
+CONFIG_RTC_DRV_MV=y
 CONFIG_DMADEVICES=y
 CONFIG_MV_XOR=y
 # CONFIG_IOMMU_SUPPORT is not set
-- 
1.7.9.5
