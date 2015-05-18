From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 18 May 2015 10:47:16 +0900
Subject: [PATCH v2 4/4] ARM: multi_v7_defconfig: Enable OHCI on Exynos
In-Reply-To: <1431913636-31854-1-git-send-email-k.kozlowski@samsung.com>
References: <1431913636-31854-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1431913636-31854-5-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>

Enable the USB OHCI driver for Exynos SoCs: S5PV210, Exynos4 family,
Exynos5250, Exynos5440 and Exynos542x/5800 family.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 8fa7171b12f3..fe88429b9279 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -455,6 +455,7 @@ CONFIG_USB_ISP1760_HCD=y
 CONFIG_USB_OHCI_HCD=y
 CONFIG_USB_OHCI_HCD_STI=y
 CONFIG_USB_OHCI_HCD_PLATFORM=y
+CONFIG_USB_OHCI_EXYNOS=m
 CONFIG_USB_R8A66597_HCD=m
 CONFIG_USB_RENESAS_USBHS=m
 CONFIG_USB_STORAGE=y
-- 
1.9.1
