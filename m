From: shc_work@mail.ru (Alexander Shiyan)
Date: Sun,  7 Apr 2013 19:29:14 +0400
Subject: [PATCH 3/3] ARM: dts: Add missing imx27-phytec-phycore dtb target
In-Reply-To: <1365348554-24345-1-git-send-email-shc_work@mail.ru>
References: <1365348554-24345-1-git-send-email-shc_work@mail.ru>
Message-ID: <1365348554-24345-3-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch adds missing imx27-phytec-phycore dtb target into Makefile.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/boot/dts/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 35976f0..a06d9f1 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -98,6 +98,7 @@ dtb-$(CONFIG_ARCH_MXC) += \
 	imx27-apf27.dtb \
 	imx27-apf27dev.dtb \
 	imx27-pdk.dtb \
+	imx27-phytec-phycore.dtb \
 	imx31-bug.dtb \
 	imx51-apf51.dtb \
 	imx51-apf51dev.dtb \
-- 
1.8.1.5
