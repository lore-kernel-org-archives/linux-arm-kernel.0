From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 16 Feb 2016 19:14:55 +0100
Subject: [PATCH v4 05/12] arm64: add mvebu architecture entry
In-Reply-To: <1455646502-23834-1-git-send-email-gregory.clement@free-electrons.com>
References: <1455646502-23834-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1455646502-23834-6-git-send-email-gregory.clement@free-electrons.com>
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
index 21074f674bde..85bec422d508 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -48,6 +48,12 @@ config ARCH_MEDIATEK
 	help
 	  Support for Mediatek MT65xx & MT81xx ARMv8 SoCs
 
+config ARCH_MVEBU
+	bool "Marvell EBU SoC Family"
+	help
+	  This enables support for Marvell EBU family such as the
+	  Armada 3700 SoC family.
+
 config ARCH_QCOM
 	bool "Qualcomm Platforms"
 	select PINCTRL
-- 
2.5.0
