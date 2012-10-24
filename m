From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 24 Oct 2012 15:45:25 +0100
Subject: [PATCH 5/6] ARM: ux500: Correct SDI5 address and add some format
 changes
In-Reply-To: <1351089926-32161-1-git-send-email-lee.jones@linaro.org>
References: <1351089926-32161-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1351089926-32161-6-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here we fix a simple copy and paste error and bring some node
spaces back into line with the remainder of the tree.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/dbx5x0.dtsi |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/dbx5x0.dtsi b/arch/arm/boot/dts/dbx5x0.dtsi
index 4ed1b4b..7ce45fc 100644
--- a/arch/arm/boot/dts/dbx5x0.dtsi
+++ b/arch/arm/boot/dts/dbx5x0.dtsi
@@ -552,33 +552,38 @@
 			interrupts = <0 60 0x4>;
 			status = "disabled";
 		};
+
 		sdi1_per2 at 80118000 {
 			compatible = "arm,pl18x", "arm,primecell";
 			reg = <0x80118000 0x1000>;
 			interrupts = <0 50 0x4>;
 			status = "disabled";
 		};
+
 		sdi2_per3 at 80005000 {
 			compatible = "arm,pl18x", "arm,primecell";
 			reg = <0x80005000 0x1000>;
 			interrupts = <0 41 0x4>;
 			status = "disabled";
 		};
+
 		sdi3_per2 at 80119000 {
 			compatible = "arm,pl18x", "arm,primecell";
 			reg = <0x80119000 0x1000>;
 			interrupts = <0 59 0x4>;
 			status = "disabled";
 		};
+
 		sdi4_per2 at 80114000 {
 			compatible = "arm,pl18x", "arm,primecell";
 			reg = <0x80114000 0x1000>;
 			interrupts = <0 99 0x4>;
 			status = "disabled";
 		};
+
 		sdi5_per3 at 80008000 {
 			compatible = "arm,pl18x", "arm,primecell";
-			reg = <0x80114000 0x1000>;
+			reg = <0x80008000 0x1000>;
 			interrupts = <0 100 0x4>;
 			status = "disabled";
 		};
-- 
1.7.9.5
