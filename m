From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 22 Jul 2013 11:52:40 +0100
Subject: [PATCH 21/22] ARM: SPEAr3xx: DT: Remove '0x's from Spear 310 DTS file
In-Reply-To: <1374490361-25769-1-git-send-email-lee.jones@linaro.org>
References: <1374490361-25769-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1374490361-25769-21-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/spear310.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/spear310.dtsi b/arch/arm/boot/dts/spear310.dtsi
index 9537208..dc263e4 100644
--- a/arch/arm/boot/dts/spear310.dtsi
+++ b/arch/arm/boot/dts/spear310.dtsi
@@ -40,7 +40,7 @@
 			status = "disabled";
 		};
 
-		shirq: interrupt-controller at 0xb4000000 {
+		shirq: interrupt-controller at b4000000 {
 			compatible = "st,spear310-shirq";
 			reg = <0xb4000000 0x1000>;
 			interrupts = <28 29 30 1>;
-- 
1.8.1.2
