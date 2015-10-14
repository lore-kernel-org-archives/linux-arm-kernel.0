From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Wed, 14 Oct 2015 12:34:04 +0200
Subject: [PATCH 4/4] ARM: multi_v7_defconfig: enable the Berlin ADC
In-Reply-To: <1444818844-2865-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1444818844-2865-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <1444818844-2865-5-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the Marvell Berlin ADC support in multi_v7_defconfig.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index e45f80df403c..2d5c77286a2a 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -637,6 +637,7 @@ CONFIG_EXTCON=y
 CONFIG_TI_AEMIF=y
 CONFIG_IIO=y
 CONFIG_AT91_ADC=m
+CONFIG_BERLIN2_ADC=y
 CONFIG_EXYNOS_ADC=m
 CONFIG_XILINX_XADC=y
 CONFIG_AK8975=y
-- 
2.6.1
