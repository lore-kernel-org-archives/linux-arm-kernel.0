From: b-cousson@ti.com (Benoit Cousson)
Date: Thu, 1 Sep 2011 19:21:24 +0200
Subject: [PATCH 08/13] arm/dts: omap4-panda: Set clock freq for i2c controllers
In-Reply-To: <1314897689-17791-1-git-send-email-b-cousson@ti.com>
References: <1314897689-17791-1-git-send-email-b-cousson@ti.com>
Message-ID: <1314897689-17791-9-git-send-email-b-cousson@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: G, Manjunath Kondaiah <manjugk@ti.com>

Update pandaboard dts file with required clock frequencies
for the i2c client devices existing on pandaboard.

Signed-off-by: G, Manjunath Kondaiah <manjugk@ti.com>
[b-cousson at ti.com: Fix the wrong use of reference and
wrong clock value]
Signed-off-by: Benoit Cousson <b-cousson@ti.com>
---
 arch/arm/boot/dts/omap4-panda.dts |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap4-panda.dts b/arch/arm/boot/dts/omap4-panda.dts
index c702657..63ecf34 100644
--- a/arch/arm/boot/dts/omap4-panda.dts
+++ b/arch/arm/boot/dts/omap4-panda.dts
@@ -27,3 +27,19 @@
 		reg = <0x80000000 0x40000000>; /* 1 GB */
 	};
 };
+
+&i2c1 {
+	clock-frequency = <400000>;
+};
+
+&i2c2 {
+	clock-frequency = <400000>;
+};
+
+&i2c3 {
+	clock-frequency = <100000>;
+};
+
+&i2c4 {
+	clock-frequency = <400000>;
+};
-- 
1.7.0.4
