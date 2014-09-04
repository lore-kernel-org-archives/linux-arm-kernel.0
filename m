From: gabriel.fernandez@st.com (Gabriel FERNANDEZ)
Date: Thu,  4 Sep 2014 14:59:38 +0200
Subject: [PATCH] ARM: STi: DT: STiH407: Fix: clk-tmds-hdmi clock is missing
Message-ID: <1409835579-23541-1-git-send-email-gabriel.fernandez@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Gabriel Fernandez <gabriel.fernandez@linaro.org>
---
 arch/arm/boot/dts/stih407-clock.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/stih407-clock.dtsi b/arch/arm/boot/dts/stih407-clock.dtsi
index b4318e1..d8488c0 100644
--- a/arch/arm/boot/dts/stih407-clock.dtsi
+++ b/arch/arm/boot/dts/stih407-clock.dtsi
@@ -272,7 +272,7 @@
 						     "clk-pix-dvo",
 						     "clk-dvo",
 						     "clk-pix-hdmi",
-						     "",
+						     "clk-tmds-hdmi",
 						     "clk-ref-hdmiphy";
 						     };
 		};
-- 
1.9.1
