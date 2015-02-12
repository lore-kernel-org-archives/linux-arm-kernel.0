From: marek@goldelico.com (Marek Belisko)
Date: Thu, 12 Feb 2015 14:03:46 +0100
Subject: [PATCH 4/4] ARM: dts: omap3-pandora: include in dts Makefile
In-Reply-To: <1423746226-700-1-git-send-email-marek@goldelico.com>
References: <1423746226-700-1-git-send-email-marek@goldelico.com>
Message-ID: <1423746226-700-5-git-send-email-marek@goldelico.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "H. Nikolaus Schaller" <hns@goldelico.com>

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/arm/boot/dts/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 91bd5bd..69f3106 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -343,6 +343,8 @@ dtb-$(CONFIG_ARCH_OMAP3) += am3517-craneboard.dtb \
 	omap3-overo-storm-tobi.dtb \
 	omap3-overo-summit.dtb \
 	omap3-overo-tobi.dtb \
+	omap3-pandora-600mhz.dtb \
+	omap3-pandora-1ghz.dtb \
 	omap3-sbc-t3517.dtb \
 	omap3-sbc-t3530.dtb \
 	omap3-sbc-t3730.dtb \
-- 
1.9.1
