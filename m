From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 15 Feb 2016 09:47:42 +0100
Subject: [PATCH 2/5] Documentation: arm: add Marvell Armada 7K and 8K families
In-Reply-To: <1455526065-7307-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1455526065-7307-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1455526065-7307-3-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As we are adding support for the Armada 7K and 8K families, this
commit adds them to the Marvell documentation listing all supported
SoCs, together with references to their Product Brief, Homepage and
Device Tree files.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 Documentation/arm/Marvell/README | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/Documentation/arm/Marvell/README b/Documentation/arm/Marvell/README
index b92ee66..74f7ce3 100644
--- a/Documentation/arm/Marvell/README
+++ b/Documentation/arm/Marvell/README
@@ -130,6 +130,26 @@ EBU Armada family ARMv8
 	Product Brief: http://www.marvell.com/embedded-processors/assets/PB-88F3700-FNL.pdf
 	Device tree files: arch/arm64/boot/dts/marvell/armada-37*
 
+  Armada 7K Flavors:
+	88F7020 (AP806 Dual + one CP110)
+	88F7040 (AP806 Quad + one CP110)
+	Core: ARM Cortex A72
+
+	Homepage: http://www.marvell.com/embedded-processors/armada-70xx/
+	Product Brief: http://www.marvell.com/embedded-processors/assets/Armada7020PB-Jan2016.pdf
+		       http://www.marvell.com/embedded-processors/assets/Armada7040PB-Jan2016.pdf
+	Device tree files: arch/arm64/boot/dts/marvell/armada-70*
+
+  Armada 8K Flavors:
+	88F8020 (AP806 Dual + two CP110)
+	88F8040 (AP806 Quad + two CP110)
+	Core: ARM Cortex A72
+
+	Homepage: http://www.marvell.com/embedded-processors/armada-80xx/
+	Product Brief: http://www.marvell.com/embedded-processors/assets/Armada8020PB-Jan2016.pdf
+		       http://www.marvell.com/embedded-processors/assets/Armada8040PB-Jan2016.pdf
+	Device tree files: arch/arm64/boot/dts/marvell/armada-80*
+
 Avanta family
 -------------
 
-- 
2.6.4
