From: lee.jones@linaro.org (Lee Jones)
Date: Mon,  3 Jun 2013 14:42:30 +0100
Subject: [PATCH 06/21] ARM: ux500: Supply the USB clock lookup to the DBX500 DT
In-Reply-To: <1370266965-7901-1-git-send-email-lee.jones@linaro.org>
References: <1370266965-7901-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1370266965-7901-7-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/dbx5x0.dtsi |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/dbx5x0.dtsi b/arch/arm/boot/dts/dbx5x0.dtsi
index fa3fd41..c5acbc9 100644
--- a/arch/arm/boot/dts/dbx5x0.dtsi
+++ b/arch/arm/boot/dts/dbx5x0.dtsi
@@ -232,6 +232,8 @@
 				    "iep_6_14", "oep_6_14",
 				    "iep_7_15", "oep_7_15",
 				    "iep_8",    "oep_8";
+
+			clocks = <&clk 73>;
 		};
 
 		dma: dma-controller at 801C0000 {
-- 
1.7.10.4
