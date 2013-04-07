From: shc_work@mail.ru (Alexander Shiyan)
Date: Sun,  7 Apr 2013 19:29:13 +0400
Subject: [PATCH 2/3] ARM: dts: Add SPI support for i.MX27 Phytec PCM038 module
In-Reply-To: <1365348554-24345-1-git-send-email-shc_work@mail.ru>
References: <1365348554-24345-1-git-send-email-shc_work@mail.ru>
Message-ID: <1365348554-24345-2-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Added SPI node to imx27-phytec-phycore DT file.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/boot/dts/imx27-phytec-phycore.dtsp | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/imx27-phytec-phycore.dtsp b/arch/arm/boot/dts/imx27-phytec-phycore.dtsp
index 7228153..354dc77 100644
--- a/arch/arm/boot/dts/imx27-phytec-phycore.dtsp
+++ b/arch/arm/boot/dts/imx27-phytec-phycore.dtsp
@@ -77,3 +77,9 @@
 	nand-ecc-mode = "hw";
 	status = "okay";
 };
+
+&cspi1 {
+	fsl,spi-num-chipselects = <1>;
+	cs-gpios = <&gpio4 28 0>;
+	status = "okay";
+};
-- 
1.8.1.5
