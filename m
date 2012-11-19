From: i.mazanov@gmail.com (Igor Mazanov)
Date: Mon, 19 Nov 2012 15:45:25 +0400
Subject: [PATCH] OMAP2+: enable TPS65217 support in omap2plus_defconfig
Message-ID: <50AA1BD5.1000002@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

TPS65217 is described in arch/arm/boot/dts/am335x-bone.dts
but doesn't enabled in arch/arm/configs/omap2plus_defconfig.

Enable TPS65217 support in omap2plus_defconfig.

Signed-off-by: Igor Mazanov <i.mazanov@gmail.com>
---
  arch/arm/configs/omap2plus_defconfig |    3 +++
  1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/configs/omap2plus_defconfig 
b/arch/arm/configs/omap2plus_defconfig
index 6230304..00f2ce3 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -240,3 +240,6 @@ CONFIG_CRC_ITU_T=y
  CONFIG_CRC7=y
  CONFIG_LIBCRC32C=y
  CONFIG_SOC_OMAP5=y
+CONFIG_MFD_CORE=y
+CONFIG_MFD_TPS65217=y
+CONFIG_REGULATOR_TPS65217=y
--
1.7.4.4
