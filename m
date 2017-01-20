From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Fri, 20 Jan 2017 23:21:06 +0100
Subject: [PATCH 06/18] ARM64: dts: meson-gxm-nexbox-a1: Drop UART comment
In-Reply-To: <20170120222118.21476-1-afaerber@suse.de>
References: <20170120222118.21476-1-afaerber@suse.de>
Message-ID: <20170120222118.21476-7-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Product pictures show no DB9 connector, so this seems copy&paste.

Cc: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts b/arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts
index 5a337d339df1..439060652689 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts
@@ -102,7 +102,6 @@
 	};
 };
 
-/* This UART is brought out to the DB9 connector */
 &uart_AO {
 	status = "okay";
 	pinctrl-0 = <&uart_ao_a_pins>;
-- 
2.10.2
