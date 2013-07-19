From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 19 Jul 2013 14:58:35 +0100
Subject: [PATCH 04/22] ARM: ux500: Remove '0x's from Animeo IP DTS file
In-Reply-To: <1374242333-6852-1-git-send-email-lee.jones@linaro.org>
References: <1374242333-6852-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1374242333-6852-4-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/animeo_ip.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/animeo_ip.dts b/arch/arm/boot/dts/animeo_ip.dts
index 3a1de9e..4cb0342 100644
--- a/arch/arm/boot/dts/animeo_ip.dts
+++ b/arch/arm/boot/dts/animeo_ip.dts
@@ -105,7 +105,7 @@
 				reg = <0x48000 0x8000>;
 			};
 
-			user_block at 0x50000 {
+			user_block at 50000 {
 				label = "user_block";
 				reg = <0x50000 0xb0000>;
 			};
-- 
1.8.1.2
