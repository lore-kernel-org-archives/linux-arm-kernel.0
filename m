From: akshay.bhat@timesys.com (Akshay Bhat)
Date: Thu,  5 Nov 2015 13:13:43 -0500
Subject: [PATCH v2 09/10] ARM: dts: imx: Add mma8453 support
In-Reply-To: <1446747224-32514-1-git-send-email-akshay.bhat@timesys.com>
References: <1446747224-32514-1-git-send-email-akshay.bhat@timesys.com>
Message-ID: <1446747224-32514-10-git-send-email-akshay.bhat@timesys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Akshay Bhat <akshay.bhat@timesys.com>
---
 arch/arm/boot/dts/imx6q-bx50v3.dtsi | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6q-bx50v3.dtsi b/arch/arm/boot/dts/imx6q-bx50v3.dtsi
index e9d97ee..2715cd9 100644
--- a/arch/arm/boot/dts/imx6q-bx50v3.dtsi
+++ b/arch/arm/boot/dts/imx6q-bx50v3.dtsi
@@ -1,6 +1,6 @@
 /*
  * Copyright 2015 Timesys Corporation.
- * Copyright 2015 GE Healthcare.
+ * Copyright 2015 General Electric Company
  *
  * The code contained herein is licensed under the GNU General Public
  * License. You may obtain a copy of the GNU General Public License
@@ -79,6 +79,11 @@
 				compatible = "ti,ads7830";
 				reg = <0x48>;
 			};
+
+			mma8453: mma8453 at 1c {
+				compatible = "fsl,mma8453";
+				reg = <0x1c>;
+			};
 		};
 
 		mux_i2c4: i2c at 1 {
-- 
2.6.2
