From: lee.jones@linaro.org (Lee Jones)
Date: Wed,  6 Nov 2013 10:16:17 +0000
Subject: [PATCH 05/13] ARM: ux500: Add ID properties to 'simply' differentiate
 between MSPs
In-Reply-To: <1383732985-18928-1-git-send-email-lee.jones@linaro.org>
References: <1383732985-18928-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1383732985-18928-6-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/ste-dbx5x0.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/ste-dbx5x0.dtsi b/arch/arm/boot/dts/ste-dbx5x0.dtsi
index 50ff5ab..63861ee 100644
--- a/arch/arm/boot/dts/ste-dbx5x0.dtsi
+++ b/arch/arm/boot/dts/ste-dbx5x0.dtsi
@@ -920,6 +920,8 @@
 			clocks = <&prcc_kclk 1 3>, <&prcc_pclk 1 3>;
 			clock-names = "msp", "apb_pclk";
 
+			id = <0>;
+
 			status = "disabled";
 		};
 
@@ -935,6 +937,8 @@
 			clocks = <&prcc_kclk 1 4>, <&prcc_pclk 1 4>;
 			clock-names = "msp", "apb_pclk";
 
+			id = <1>;
+
 			status = "disabled";
 		};
 
@@ -953,6 +957,8 @@
 			clocks = <&prcc_kclk 2 3>, <&prcc_pclk 2 5>;
 			clock-names = "msp", "apb_pclk";
 
+			id = <2>;
+
 			status = "disabled";
 		};
 
@@ -968,6 +974,8 @@
 			clocks = <&prcc_kclk 1 10>, <&prcc_pclk 1 11>;
 			clock-names = "msp", "apb_pclk";
 
+			id = <3>;
+
 			status = "disabled";
 		};
 
-- 
1.8.1.2
