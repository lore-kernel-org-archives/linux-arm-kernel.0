From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 25 May 2018 16:01:47 +0530
Subject: [PATCH 01/15] arm: dts: armada: Fix "#cooling-cells" property's name
In-Reply-To: <cover.1527244200.git.viresh.kumar@linaro.org>
References: <cover.1527244200.git.viresh.kumar@linaro.org>
Message-ID: <26a0666368694db610414a85a08843435ea070a7.1527244201.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It should be "#cooling-cells" instead of "cooling-cells". Fix it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/arm/boot/dts/armada-385-synology-ds116.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/armada-385-synology-ds116.dts b/arch/arm/boot/dts/armada-385-synology-ds116.dts
index 6782ce481ac9..d8769956cbfc 100644
--- a/arch/arm/boot/dts/armada-385-synology-ds116.dts
+++ b/arch/arm/boot/dts/armada-385-synology-ds116.dts
@@ -139,7 +139,7 @@
 					      3700 5
 					      3900 6
 					      4000 7>;
-			cooling-cells = <2>;
+			#cooling-cells = <2>;
 		};
 
 		gpio-leds {
-- 
2.15.0.194.g9af6a3dea062
