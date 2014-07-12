From: horms+renesas@verge.net.au (Simon Horman)
Date: Sat, 12 Jul 2014 15:53:24 +0200
Subject: [PATCH] ARM: shmobile: Enable R-Car Gen 2 PCIe in shmobile_defconfig
In-Reply-To: <cover.1405173007.git.horms+renesas@verge.net.au>
References: <cover.1405173007.git.horms+renesas@verge.net.au>
Message-ID: <8cbf869a0a278c4d39e50daa4f4101b394a72a93.1405173007.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The R-Car Gen 2 PCIe driver provides PCIe host support for
Renesas R-Car Gen2 platforms. To increase hardware support enable
the driver in the shmobile_defconfig multiplatform configuration.

Cc: Phil Edworthy <phil.edworthy@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/configs/shmobile_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
index 5f05e98..6bc85a5 100644
--- a/arch/arm/configs/shmobile_defconfig
+++ b/arch/arm/configs/shmobile_defconfig
@@ -24,6 +24,7 @@ CONFIG_PL310_ERRATA_588369=y
 CONFIG_ARM_ERRATA_754322=y
 CONFIG_PCI=y
 CONFIG_PCI_RCAR_GEN2=y
+CONFIG_PCI_RCAR_GEN2_PCIE=y
 CONFIG_SMP=y
 CONFIG_SCHED_MC=y
 CONFIG_HAVE_ARM_ARCH_TIMER=y
-- 
2.0.0.rc2
