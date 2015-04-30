From: g.portay@overkiz.com (=?UTF-8?q?Ga=C3=ABl=20PORTAY?=)
Date: Thu, 30 Apr 2015 09:33:32 +0200
Subject: [PATCH v3 1/7] ARM: at91/dt: kizbox: rename to at91-kizbox
In-Reply-To: <1430379218-13758-1-git-send-email-g.portay@overkiz.com>
References: <1430379218-13758-1-git-send-email-g.portay@overkiz.com>
Message-ID: <1430379218-13758-2-git-send-email-g.portay@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rename to match AT91 naming convention.

Signed-off-by: Ga?l PORTAY <g.portay@overkiz.com>
Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 arch/arm/boot/dts/Makefile                        | 2 +-
 arch/arm/boot/dts/{kizbox.dts => at91-kizbox.dts} | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
 rename arch/arm/boot/dts/{kizbox.dts => at91-kizbox.dts} (97%)

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index a1c776b..21726fd 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -18,9 +18,9 @@ dtb-$(CONFIG_SOC_SAM_V4_V5) += \
 	tny_a9263.dtb \
 	usb_a9263.dtb \
 	at91-foxg20.dtb \
+	at91-kizbox.dtb \
 	at91sam9g20ek.dtb \
 	at91sam9g20ek_2mmc.dtb \
-	kizbox.dtb \
 	tny_a9g20.dtb \
 	usb_a9g20.dtb \
 	usb_a9g20_lpw.dtb \
diff --git a/arch/arm/boot/dts/kizbox.dts b/arch/arm/boot/dts/at91-kizbox.dts
similarity index 97%
rename from arch/arm/boot/dts/kizbox.dts
rename to arch/arm/boot/dts/at91-kizbox.dts
index e83e4f9..e07afae 100644
--- a/arch/arm/boot/dts/kizbox.dts
+++ b/arch/arm/boot/dts/at91-kizbox.dts
@@ -1,5 +1,5 @@
 /*
- * kizbox.dts - Device Tree file for Overkiz Kizbox board
+ * at91-kizbox.dts - Device Tree file for Overkiz Kizbox board
  *
  * Copyright (C) 2012 Boris BREZILLON <linux-arm@overkiz.com>
  *
-- 
1.9.1
