From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Thu, 01 Sep 2016 11:21:51 +0200
Subject: [PATCH 2/6] pinctrl: dt-bindings: samsung: Add macros for S3C64xx pin
 configuration
In-Reply-To: <1472721715-2833-1-git-send-email-k.kozlowski@samsung.com>
References: <1472721715-2833-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1472721715-2833-3-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add macros for configuring pins pull up/down on S3C64xx and S5PV210.
They differ from Exynos SoC family.  Also add pin function with value of 6.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 include/dt-bindings/pinctrl/samsung.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/dt-bindings/pinctrl/samsung.h b/include/dt-bindings/pinctrl/samsung.h
index b2132f3fe1ac..8ba07a6de003 100644
--- a/include/dt-bindings/pinctrl/samsung.h
+++ b/include/dt-bindings/pinctrl/samsung.h
@@ -17,6 +17,10 @@
 #define EXYNOS_PIN_PULL_DOWN		1
 #define EXYNOS_PIN_PULL_UP		3
 
+#define S3C64XX_PIN_PULL_NONE		0
+#define S3C64XX_PIN_PULL_DOWN		1
+#define S3C64XX_PIN_PULL_UP		2
+
 /* Pin function in power down mode */
 #define EXYNOS_PIN_PDN_OUT0		0
 #define EXYNOS_PIN_PDN_OUT1		1
@@ -47,6 +51,7 @@
 #define EXYNOS_PIN_FUNC_3		3
 #define EXYNOS_PIN_FUNC_4		4
 #define EXYNOS_PIN_FUNC_5		5
+#define EXYNOS_PIN_FUNC_6		6
 #define EXYNOS_PIN_FUNC_F		0xf
 
 #endif /* __DT_BINDINGS_PINCTRL_EXYNOS_H__ */
-- 
1.9.1
