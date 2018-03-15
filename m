From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 15 Mar 2018 15:29:28 -0300
Subject: [PATCH 1/2] ARM: dts: imx6-phytec: Use the standard 'stdout-path'
 property
Message-ID: <1521138569-8125-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

Use the standard 'stdout-path' property to fix the following DTC warnings:

arch/arm/boot/dts/imx6dl-phytec-mira-rdk-nand.dtb: Warning
(chosen_node_stdout_path): /chosen:linux,stdout-path: Use
'stdout-path' instead

Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx6dl-phytec-mira-rdk-nand.dts | 2 +-
 arch/arm/boot/dts/imx6q-phytec-mira-rdk-emmc.dts  | 2 +-
 arch/arm/boot/dts/imx6q-phytec-mira-rdk-nand.dts  | 2 +-
 arch/arm/boot/dts/imx6qp-phytec-mira-rdk-nand.dts | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/imx6dl-phytec-mira-rdk-nand.dts b/arch/arm/boot/dts/imx6dl-phytec-mira-rdk-nand.dts
index a8adcb2..9f7f9f9 100644
--- a/arch/arm/boot/dts/imx6dl-phytec-mira-rdk-nand.dts
+++ b/arch/arm/boot/dts/imx6dl-phytec-mira-rdk-nand.dts
@@ -15,7 +15,7 @@
 		     "phytec,imx6qdl-pcm058", "fsl,imx6dl";
 
 	chosen {
-		linux,stdout-path = &uart2;
+		stdout-path = &uart2;
 	};
 };
 
diff --git a/arch/arm/boot/dts/imx6q-phytec-mira-rdk-emmc.dts b/arch/arm/boot/dts/imx6q-phytec-mira-rdk-emmc.dts
index 8fdce3c..2e70ea5 100644
--- a/arch/arm/boot/dts/imx6q-phytec-mira-rdk-emmc.dts
+++ b/arch/arm/boot/dts/imx6q-phytec-mira-rdk-emmc.dts
@@ -15,7 +15,7 @@
 		     "phytec,imx6qdl-pcm058", "fsl,imx6q";
 
 	chosen {
-		linux,stdout-path = &uart2;
+		stdout-path = &uart2;
 	};
 };
 
diff --git a/arch/arm/boot/dts/imx6q-phytec-mira-rdk-nand.dts b/arch/arm/boot/dts/imx6q-phytec-mira-rdk-nand.dts
index 8afa5ce..65d2e48 100644
--- a/arch/arm/boot/dts/imx6q-phytec-mira-rdk-nand.dts
+++ b/arch/arm/boot/dts/imx6q-phytec-mira-rdk-nand.dts
@@ -15,7 +15,7 @@
 		     "phytec,imx6qdl-pcm058", "fsl,imx6q";
 
 	chosen {
-		linux,stdout-path = &uart2;
+		stdout-path = &uart2;
 	};
 };
 
diff --git a/arch/arm/boot/dts/imx6qp-phytec-mira-rdk-nand.dts b/arch/arm/boot/dts/imx6qp-phytec-mira-rdk-nand.dts
index 3618e53..f27d7ab 100644
--- a/arch/arm/boot/dts/imx6qp-phytec-mira-rdk-nand.dts
+++ b/arch/arm/boot/dts/imx6qp-phytec-mira-rdk-nand.dts
@@ -15,7 +15,7 @@
 		     "phytec,imx6qdl-pcm058", "fsl,imx6qp";
 
 	chosen {
-		linux,stdout-path = &uart2;
+		stdout-path = &uart2;
 	};
 };
 
-- 
2.7.4
