From: michel.pollet@bp.renesas.com (Michel Pollet)
Date: Thu, 22 Mar 2018 11:44:45 +0000
Subject: [PATCH v2 8/8] DT: arm: Add the RZN1D-DB Board to Renesas Makefile
 target
In-Reply-To: <1521719091-25157-1-git-send-email-michel.pollet@bp.renesas.com>
References: <1521719091-25157-1-git-send-email-michel.pollet@bp.renesas.com>
Message-ID: <1521719091-25157-9-git-send-email-michel.pollet@bp.renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the newly added board to the Renesas built target

Signed-off-by: Michel Pollet <michel.pollet@bp.renesas.com>
---
 arch/arm/boot/dts/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 3b4cc1b..0f01ada 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -806,6 +806,7 @@ dtb-$(CONFIG_ARCH_RENESAS) += \
 	r8a7793-gose.dtb \
 	r8a7794-alt.dtb \
 	r8a7794-silk.dtb \
+	r9a06g032-rzn1d400-db.dtb \
 	sh73a0-kzm9g.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += \
 	rv1108-evb.dtb \
-- 
2.7.4
