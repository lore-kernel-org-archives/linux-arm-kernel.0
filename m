From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 18 May 2012 09:39:11 +0100
Subject: [PATCH 12/16] ARM: ux500: Add db8500 Device Tree node for
 misc/ab8500-pwm
In-Reply-To: <1337330355-17747-1-git-send-email-lee.jones@linaro.org>
References: <1337330355-17747-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1337330355-17747-13-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the DT node for the misc/ab8500-pwm driver. It will
allow probing of the driver during a Device Tree enabled boot.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/db8500.dtsi |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/db8500.dtsi b/arch/arm/boot/dts/db8500.dtsi
index 3c00e0670..37dcc13 100644
--- a/arch/arm/boot/dts/db8500.dtsi
+++ b/arch/arm/boot/dts/db8500.dtsi
@@ -333,6 +333,10 @@
 					compatible = "stericsson,ab8500-sysctrl";
 				};
 
+				ab8500-pwm {
+					compatible = "stericsson,ab8500-pwm";
+				};
+
 				ab8500-regulators {
 					compatible = "stericsson,ab8500-regulator";
 
-- 
1.7.9.5
