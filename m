From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Wed,  2 Apr 2014 21:34:23 +0800
Subject: [PATCH 2/2] ARM: dts: fix L2 address in Hi3620
In-Reply-To: <1396445663-1357-1-git-send-email-haojian.zhuang@linaro.org>
References: <1396445663-1357-1-git-send-email-haojian.zhuang@linaro.org>
Message-ID: <1396445663-1357-2-git-send-email-haojian.zhuang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the address of L2 controler register in hi3620 SoC.

Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
---
 arch/arm/boot/dts/hi3620.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/hi3620.dtsi b/arch/arm/boot/dts/hi3620.dtsi
index ab1116d..83a5b86 100644
--- a/arch/arm/boot/dts/hi3620.dtsi
+++ b/arch/arm/boot/dts/hi3620.dtsi
@@ -73,7 +73,7 @@
 
 		L2: l2-cache {
 			compatible = "arm,pl310-cache";
-			reg = <0xfc10000 0x100000>;
+			reg = <0x100000 0x100000>;
 			interrupts = <0 15 4>;
 			cache-unified;
 			cache-level = <2>;
-- 
1.8.3.2
