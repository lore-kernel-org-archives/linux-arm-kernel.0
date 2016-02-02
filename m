From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue,  2 Feb 2016 19:07:41 +0100
Subject: [PATCH 03/10] arm64: add Armada 3700 architecture entry
In-Reply-To: <1454436468-4241-1-git-send-email-gregory.clement@free-electrons.com>
References: <1454436468-4241-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1454436468-4241-4-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Armada 3700 is an mvebu ARM64 SoC using one or two Cortex-A53 cores
depending of the variant.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Reviewed-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm64/Kconfig.platforms | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 21074f674bde..7da341f7b90d 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -1,5 +1,11 @@
 menu "Platform selection"
 
+config ARCH_ARMADA_3700
+	bool "Armada 3700 SoC Family"
+	help
+	  This enables support for Armada 3700 SoC Family. It is is an
+	  ARMv8 based chipset belonging to the mvebu family.
+
 config ARCH_BCM_IPROC
 	bool "Broadcom iProc SoC Family"
 	help
-- 
2.5.0
