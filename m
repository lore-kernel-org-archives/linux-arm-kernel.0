From: shc_work@mail.ru (Alexander Shiyan)
Date: Sat,  1 Jun 2013 09:54:11 +0400
Subject: [PATCH 2/4] ARM: dts: imx27-phytec-phycore: Rename file to match
 functionality
In-Reply-To: <1370066053-25030-1-git-send-email-shc_work@mail.ru>
References: <1370066053-25030-1-git-send-email-shc_work@mail.ru>
Message-ID: <1370066053-25030-2-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PCM038 dts can be used as base for development kit board or any
custom PCB designs. Renames this file to match functionality.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/boot/dts/Makefile                                              | 2 +-
 .../boot/dts/{imx27-phytec-phycore.dts => imx27-phytec-phycore-som.dts} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename arch/arm/boot/dts/{imx27-phytec-phycore.dts => imx27-phytec-phycore-som.dts} (100%)

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 78695bd..8450c14 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -107,7 +107,7 @@ dtb-$(CONFIG_ARCH_MXC) += \
 	imx27-apf27.dtb \
 	imx27-apf27dev.dtb \
 	imx27-pdk.dtb \
-	imx27-phytec-phycore.dtb \
+	imx27-phytec-phycore-som.dtb \
 	imx31-bug.dtb \
 	imx51-apf51.dtb \
 	imx51-apf51dev.dtb \
diff --git a/arch/arm/boot/dts/imx27-phytec-phycore.dts b/arch/arm/boot/dts/imx27-phytec-phycore-som.dts
similarity index 100%
rename from arch/arm/boot/dts/imx27-phytec-phycore.dts
rename to arch/arm/boot/dts/imx27-phytec-phycore-som.dts
-- 
1.8.1.5
