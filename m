From: manivannan.sadhasivam@linaro.org (Manivannan Sadhasivam)
Date: Fri,  2 Mar 2018 09:20:38 +0530
Subject: [PATCH v4 03/10] arm64: actions: Enable PINCTRL in platforms Kconfig
In-Reply-To: <20180302035045.14660-1-manivannan.sadhasivam@linaro.org>
References: <20180302035045.14660-1-manivannan.sadhasivam@linaro.org>
Message-ID: <20180302035045.14660-4-manivannan.sadhasivam@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Select PINCTRL for Actions Semi SoCs

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/Kconfig.platforms | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index fbedbd8f619a..bae1289bdc3f 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -3,6 +3,7 @@ menu "Platform selection"
 config ARCH_ACTIONS
 	bool "Actions Semi Platforms"
 	select OWL_TIMER
+	select PINCTRL
 	help
 	  This enables support for the Actions Semiconductor S900 SoC family.
 
-- 
2.14.1
