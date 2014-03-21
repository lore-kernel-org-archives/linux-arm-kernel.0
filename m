From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Fri, 21 Mar 2014 13:14:06 +0100
Subject: [PATCH 09/20] ARM: nomadik: Convert to the common mmc DT bindings for
 highspeed mode
In-Reply-To: <1395404057-27835-1-git-send-email-ulf.hansson@linaro.org>
References: <1395404057-27835-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <1395404057-27835-10-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mmci host driver supports the common mmc DT parser, which enables
us to use the use common names instead.

Cc: Alessandro Rubini <rubini@unipv.it>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 arch/arm/boot/dts/ste-nomadik-stn8815.dtsi |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi b/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi
index 5acc044..d316c95 100644
--- a/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi
+++ b/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi
@@ -840,8 +840,8 @@
 			interrupts = <22>;
 			max-frequency = <48000000>;
 			bus-width = <4>;
-			mmc-cap-mmc-highspeed;
-			mmc-cap-sd-highspeed;
+			cap-mmc-highspeed;
+			cap-sd-highspeed;
 			cd-gpios = <&gpio3 15 0x1>;
 			cd-inverted;
 			pinctrl-names = "default";
-- 
1.7.9.5
