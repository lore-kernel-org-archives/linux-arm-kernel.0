From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Tue,  9 Sep 2014 18:50:58 +0200
Subject: [PATCH v3 1/7] arm: dts: Build dtb for Mediatek board
In-Reply-To: <1410281464-9587-1-git-send-email-matthias.bgg@gmail.com>
References: <1410281464-9587-1-git-send-email-matthias.bgg@gmail.com>
Message-ID: <1410281464-9587-2-git-send-email-matthias.bgg@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This allows the "make dtbs" to build the aquaris5 dtb for the Mediatek
SoC.

Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
---
 arch/arm/boot/dts/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index b8c5cd3..055b20c 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -491,6 +491,7 @@ dtb-$(CONFIG_MACH_DOVE) += dove-cm-a510.dtb \
 	dove-d2plug.dtb \
 	dove-d3plug.dtb \
 	dove-dove-db.dtb
+dtb-$(CONFIG_ARCH_MEDIATEK) += mt6589-aquaris5.dtb
 
 targets += dtbs dtbs_install
 targets += $(dtb-y)
-- 
1.9.1
