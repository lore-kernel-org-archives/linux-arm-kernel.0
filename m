From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 26 Apr 2016 18:15:47 +0200
Subject: [PATCH 4/4] ARM: multi_v7_defconfig: add the Atmel sama5d2-compatible
 ADC driver
In-Reply-To: <c1ec7d16df28a0f9d72c1106f21f1f013a0011c1.1461687187.git.nicolas.ferre@atmel.com>
References: <c1ec7d16df28a0f9d72c1106f21f1f013a0011c1.1461687187.git.nicolas.ferre@atmel.com>
Message-ID: <666b73f612875185cca22613788be0598f3ccc98.1461687187.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the new sama5d2-compatible ADC driver as a module.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 6a62ebbcae28..1aed38fd4337 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -773,6 +773,7 @@ CONFIG_EXTCON=y
 CONFIG_TI_AEMIF=y
 CONFIG_IIO=y
 CONFIG_AT91_ADC=m
+CONFIG_AT91_SAMA5D2_ADC=m
 CONFIG_BERLIN2_ADC=m
 CONFIG_EXYNOS_ADC=m
 CONFIG_VF610_ADC=m
-- 
2.1.3
