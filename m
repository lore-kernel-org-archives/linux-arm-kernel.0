From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 28 Feb 2014 22:09:26 +0100
Subject: [PATCH 2/4] ARM: r7s72100: genmai: populate extal clock node
In-Reply-To: <1393621768-12568-1-git-send-email-wsa@the-dreams.de>
References: <1393621768-12568-1-git-send-email-wsa@the-dreams.de>
Message-ID: <1393621768-12568-3-git-send-email-wsa@the-dreams.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wolfram Sang <wsa@sang-engineering.com>

Signed-off-by: Wolfram Sang <wsa@sang-engineering.com>
---
 arch/arm/boot/dts/r7s72100-genmai-reference.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/r7s72100-genmai-reference.dts b/arch/arm/boot/dts/r7s72100-genmai-reference.dts
index e664611..1d045eb 100644
--- a/arch/arm/boot/dts/r7s72100-genmai-reference.dts
+++ b/arch/arm/boot/dts/r7s72100-genmai-reference.dts
@@ -30,6 +30,10 @@
 	};
 };
 
+&extal_clk {
+	clock-frequency = <13330000>;
+};
+
 &i2c2 {
 	status = "okay";
 	clock-frequency = <400000>;
-- 
1.8.5.1
