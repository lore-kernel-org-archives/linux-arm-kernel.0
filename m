From: sachin.kamat@samsung.com (Sachin Kamat)
Date: Mon, 23 Jun 2014 15:26:24 +0530
Subject: [PATCH 2/2] ARM: multi_v7_defconfig: Enable USB3 support on Exynos
In-Reply-To: <1403517384-24288-1-git-send-email-sachin.kamat@samsung.com>
References: <1403517384-24288-1-git-send-email-sachin.kamat@samsung.com>
Message-ID: <1403517384-24288-2-git-send-email-sachin.kamat@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enables USB3 (XHCI) support on Exynos boards.

Signed-off-by: Sachin Kamat <sachin.kamat@samsung.com>
---
 arch/arm/configs/multi_v7_defconfig |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index abde73eebc57..ec17e4eae28c 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -289,6 +289,7 @@ CONFIG_USB_ISP1760_HCD=y
 CONFIG_USB_OHCI_HCD=y
 CONFIG_USB_OHCI_HCD_PLATFORM=y
 CONFIG_USB_STORAGE=y
+CONFIG_USB_DWC3=y
 CONFIG_USB_CHIPIDEA=y
 CONFIG_USB_CHIPIDEA_HOST=y
 CONFIG_AB8500_USB=y
@@ -370,6 +371,7 @@ CONFIG_PWM_TEGRA=y
 CONFIG_PWM_VT8500=y
 CONFIG_OMAP_USB2=y
 CONFIG_PHY_SUN4I_USB=y
+CONFIG_PHY_EXYNOS5_USBDRD=y
 CONFIG_EXT4_FS=y
 CONFIG_VFAT_FS=y
 CONFIG_TMPFS=y
-- 
1.7.9.5
