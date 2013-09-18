From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 18 Sep 2013 13:14:05 +0100
Subject: [PATCH 08/41] ARM: ux500: Supply the USB clock lookup to the DBX500 DT
In-Reply-To: <1379506478-16625-1-git-send-email-lee.jones@linaro.org>
References: <1379506478-16625-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1379506478-16625-9-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/dbx5x0.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/dbx5x0.dtsi b/arch/arm/boot/dts/dbx5x0.dtsi
index 089b446..2c1051d 100644
--- a/arch/arm/boot/dts/dbx5x0.dtsi
+++ b/arch/arm/boot/dts/dbx5x0.dtsi
@@ -241,6 +241,8 @@
 				    "iep_6_14", "oep_6_14",
 				    "iep_7_15", "oep_7_15",
 				    "iep_8",    "oep_8";
+
+			clocks = <&prcc_pclk 5 0>;
 		};
 
 		dma: dma-controller at 801C0000 {
-- 
1.8.1.2
