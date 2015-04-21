From: g.portay@overkiz.com (=?UTF-8?q?Ga=C3=ABl=20PORTAY?=)
Date: Tue, 21 Apr 2015 14:05:12 +0200
Subject: [PATCH v2 1/7] ARM: at91/dt: kizbox: rename to at91-kizbox
In-Reply-To: <1429617918-32086-1-git-send-email-g.portay@overkiz.com>
References: <1429617918-32086-1-git-send-email-g.portay@overkiz.com>
Message-ID: <1429617918-32086-2-git-send-email-g.portay@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rename to match AT91 naming convention.

Signed-off-by: Ga?l PORTAY <g.portay@overkiz.com>
---
 arch/arm/boot/dts/Makefile                        | 2 +-
 arch/arm/boot/dts/{kizbox.dts => at91-kizbox.dts} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename arch/arm/boot/dts/{kizbox.dts => at91-kizbox.dts} (100%)

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index d2b559d..32568fb 100644
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
similarity index 100%
rename from arch/arm/boot/dts/kizbox.dts
rename to arch/arm/boot/dts/at91-kizbox.dts
-- 
1.9.1
