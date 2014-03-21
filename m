From: phil.edworthy@renesas.com (Phil Edworthy)
Date: Fri, 21 Mar 2014 10:32:48 +0000
Subject: [PATCH v4 9/9] ARM: koelsch: Add HAVE_ARM_ARCH_TIMER to defconfig
In-Reply-To: <1395397968-6242-1-git-send-email-phil.edworthy@renesas.com>
References: <1395397968-6242-1-git-send-email-phil.edworthy@renesas.com>
Message-ID: <1395397968-6242-10-git-send-email-phil.edworthy@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is fixes a boot problem when the R-Car PCIe driver is enabled.
---
 arch/arm/configs/koelsch_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/koelsch_defconfig b/arch/arm/configs/koelsch_defconfig
index ec14547..67666b6 100644
--- a/arch/arm/configs/koelsch_defconfig
+++ b/arch/arm/configs/koelsch_defconfig
@@ -15,6 +15,7 @@ CONFIG_MACH_KOELSCH=y
 CONFIG_CPU_BPREDICT_DISABLE=y
 CONFIG_PL310_ERRATA_588369=y
 CONFIG_ARM_ERRATA_754322=y
+CONFIG_HAVE_ARM_ARCH_TIMER=y
 CONFIG_PCI=y
 CONFIG_PCI_MSI=y
 CONFIG_PCI_RCAR_GEN2_PCIE=y
-- 
1.9.0
