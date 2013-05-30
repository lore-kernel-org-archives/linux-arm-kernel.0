From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 30 May 2013 09:31:15 +0100
Subject: [PATCH] ARM: ux500: Reduce PRCMU reg-names to shorter form for u8540
 DT
Message-ID: <1369902675-5170-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After some discussion and deliberation we have decided to only use the
short form of the PRCMU register names i.e. not mention the peripheral
in which the registers reside.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/ccu8540.dts |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/ccu8540.dts b/arch/arm/boot/dts/ccu8540.dts
index af4487f..12f0bc2 100644
--- a/arch/arm/boot/dts/ccu8540.dts
+++ b/arch/arm/boot/dts/ccu8540.dts
@@ -23,7 +23,7 @@
 	soc {
 		prcmu at 80157000 {
 			reg = <0x80157000 0x2000>, <0x801b0000 0x8000>, <0x801b8000 0x3000>;
-			reg-names = "prcmu", "prcmu-tcpm-per4", "prcmu-tcdm-per4";
+			reg-names = "prcmu", "prcmu-tcpm", "prcmu-tcdm";
 		};
 
 		uart at 80120000 {
-- 
1.7.10.4
