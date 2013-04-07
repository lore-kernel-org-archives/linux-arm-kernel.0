From: shc_work@mail.ru (Alexander Shiyan)
Date: Sun,  7 Apr 2013 19:29:12 +0400
Subject: [PATCH 1/3] ARM: dts: Add NFC support for i.MX27 Phytec PCM038 module
Message-ID: <1365348554-24345-1-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Added NFC node to imx27-phytec-phycore DT file.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/boot/dts/imx27-phytec-phycore.dtsp | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/imx27-phytec-phycore.dtsp b/arch/arm/boot/dts/imx27-phytec-phycore.dtsp
index 924097a..7228153 100644
--- a/arch/arm/boot/dts/imx27-phytec-phycore.dtsp
+++ b/arch/arm/boot/dts/imx27-phytec-phycore.dtsp
@@ -71,3 +71,9 @@
 		#size-cells = <1>;
 	};
 };
+
+&nfc {
+	nand-bus-width = <8>;
+	nand-ecc-mode = "hw";
+	status = "okay";
+};
-- 
1.8.1.5
