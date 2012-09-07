From: lee.jones@linaro.org (Lee Jones)
Date: Fri,  7 Sep 2012 12:14:46 +0100
Subject: [PATCH 06/19] ARM: ux500: Add nodes for the MSP into the HREF Device
 Tree
In-Reply-To: <1347016499-29354-1-git-send-email-lee.jones@linaro.org>
References: <1347016499-29354-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1347016499-29354-7-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables the two important MSP devices for ST-Ericsson's
hardware reference development board.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/hrefv60plus.dts |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/hrefv60plus.dts b/arch/arm/boot/dts/hrefv60plus.dts
index 62b2ac1..4f0aee8 100644
--- a/arch/arm/boot/dts/hrefv60plus.dts
+++ b/arch/arm/boot/dts/hrefv60plus.dts
@@ -77,5 +77,13 @@
 
 			status = "okay";
 		};
+
+		msp1: msp at 80124000 {
+			status = "okay";
+		};
+
+		msp3: msp at 80125000 {
+			status = "okay";
+		};
 	};
 };
-- 
1.7.9.5
