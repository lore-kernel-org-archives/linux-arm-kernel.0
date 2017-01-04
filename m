From: joerg.krause@embedded.rocks (=?UTF-8?q?J=C3=B6rg=20Krause?=)
Date: Wed,  4 Jan 2017 15:22:50 +0100
Subject: [PATCH 2/2] ARM: dts: sun7i: Enable audio codec on Banana Pro
In-Reply-To: <20170104142250.22171-1-joerg.krause@embedded.rocks>
References: <20170104142250.22171-1-joerg.krause@embedded.rocks>
Message-ID: <20170104142250.22171-2-joerg.krause@embedded.rocks>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit enables the on-chip audio codec present on the A20 SoC
on the Banana Pro board.

Signed-off-by: J?rg Krause <joerg.krause@embedded.rocks>
---
 arch/arm/boot/dts/sun7i-a20-bananapro.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20-bananapro.dts b/arch/arm/boot/dts/sun7i-a20-bananapro.dts
index 439ad50dcd4a..797de4c352a5 100644
--- a/arch/arm/boot/dts/sun7i-a20-bananapro.dts
+++ b/arch/arm/boot/dts/sun7i-a20-bananapro.dts
@@ -100,6 +100,10 @@
 	status = "okay";
 };
 
+&codec {
+	status = "okay";
+};
+
 &ehci0 {
 	status = "okay";
 };
-- 
2.11.0
