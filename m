From: luaraneda@gmail.com (Luis Araneda)
Date: Thu, 28 Jun 2018 01:42:01 -0400
Subject: [RFC PATCH 1/5] arm: dts: zynq: Set correct manufacturer for ZedBoard
 and MicroZed boards
In-Reply-To: <20180628054205.17737-1-luaraneda@gmail.com>
References: <20180628054205.17737-1-luaraneda@gmail.com>
Message-ID: <20180628054205.17737-2-luaraneda@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Both boards are made by Avnet, Inc.

Signed-off-by: Luis Araneda <luaraneda@gmail.com>
---
 arch/arm/boot/dts/zynq-microzed.dts | 2 +-
 arch/arm/boot/dts/zynq-zed.dts      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/zynq-microzed.dts b/arch/arm/boot/dts/zynq-microzed.dts
index aa4a0b6de..e40f40a7f 100644
--- a/arch/arm/boot/dts/zynq-microzed.dts
+++ b/arch/arm/boot/dts/zynq-microzed.dts
@@ -8,7 +8,7 @@
 
 / {
 	model = "Zynq MicroZED Development Board";
-	compatible = "xlnx,zynq-microzed", "xlnx,zynq-7000";
+	compatible = "avnet,zynq-microzed", "xlnx,zynq-7000";
 
 	aliases {
 		ethernet0 = &gem0;
diff --git a/arch/arm/boot/dts/zynq-zed.dts b/arch/arm/boot/dts/zynq-zed.dts
index 53c6883ce..98381cc85 100644
--- a/arch/arm/boot/dts/zynq-zed.dts
+++ b/arch/arm/boot/dts/zynq-zed.dts
@@ -8,7 +8,7 @@
 
 / {
 	model = "Zynq Zed Development Board";
-	compatible = "xlnx,zynq-zed", "xlnx,zynq-7000";
+	compatible = "avnet,zynq-zed", "xlnx,zynq-7000";
 
 	aliases {
 		ethernet0 = &gem0;
-- 
2.18.0
