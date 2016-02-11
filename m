From: lars.persson@axis.com (Lars Persson)
Date: Thu, 11 Feb 2016 17:06:20 +0100
Subject: [PATCH v3 5/6] arm: multi_v7_defconfig: add MACH_ARTPEC6
In-Reply-To: <cover.1455205057.git.larper@axis.com>
References: <cover.1455205057.git.larper@axis.com>
Message-ID: <2ad1a7abcbbfc0861ac788d2df16241a501880d8.1455205057.git.larper@axis.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lars Persson <larper@axis.com>
---
 arch/arm/configs/multi_v7_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 8e8b2ac..1149642 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -16,6 +16,8 @@ CONFIG_ARCH_MULTI_V7=y
 # CONFIG_ARCH_MULTI_V4 is not set
 CONFIG_ARCH_VIRT=y
 CONFIG_ARCH_ALPINE=y
+CONFIG_ARCH_ARTPEC=y
+CONFIG_MACH_ARTPEC6=y
 CONFIG_ARCH_MVEBU=y
 CONFIG_MACH_ARMADA_370=y
 CONFIG_MACH_ARMADA_375=y
@@ -227,6 +229,7 @@ CONFIG_R8169=y
 CONFIG_SH_ETH=y
 CONFIG_SMSC911X=y
 CONFIG_STMMAC_ETH=y
+CONFIG_SYNOPSYS_DWC_ETH_QOS=y
 CONFIG_TI_CPSW=y
 CONFIG_XILINX_EMACLITE=y
 CONFIG_AT803X_PHY=y
-- 
2.1.4
