From: k.kozlowski.k@gmail.com (Krzysztof Kozlowski)
Date: Fri, 15 May 2015 21:49:02 +0900
Subject: [PATCH 4/4] ARM: multi_v7_defconfig: Enable OHCI on Exynos
In-Reply-To: <1431694142-32141-1-git-send-email-k.kozlowski.k@gmail.com>
References: <1431694142-32141-1-git-send-email-k.kozlowski.k@gmail.com>
Message-ID: <1431694142-32141-5-git-send-email-k.kozlowski.k@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the USB OHCI driver for Exynos SoCs: S5PV210, Exynos4 family,
Exynos5250, Exynos5440 and Exynos542x/5800 family.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 6ee2c24dfbc7..b3573c01f34c 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -456,6 +456,7 @@ CONFIG_USB_ISP1760_HCD=y
 CONFIG_USB_OHCI_HCD=y
 CONFIG_USB_OHCI_HCD_STI=y
 CONFIG_USB_OHCI_HCD_PLATFORM=y
+CONFIG_USB_OHCI_EXYNOS=y
 CONFIG_USB_R8A66597_HCD=m
 CONFIG_USB_RENESAS_USBHS=m
 CONFIG_USB_STORAGE=y
-- 
2.1.4
