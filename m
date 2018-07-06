From: luaraneda@gmail.com (Luis Araneda)
Date: Fri,  6 Jul 2018 02:01:56 -0400
Subject: [PATCH v2 1/3] arm: dts: zynq: Set correct manufacturer for ZedBoard
 and MicroZed boards
In-Reply-To: <20180706060158.24155-1-luaraneda@gmail.com>
References: <20180706060158.24155-1-luaraneda@gmail.com>
Message-ID: <20180706060158.24155-2-luaraneda@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Both boards are made by Avnet, Inc. So add an additional
value to the compatible property

Signed-off-by: Luis Araneda <luaraneda@gmail.com>
---

Changes since v1 (RFC):
- Add values to compatible property instead of replacing them

 arch/arm/boot/dts/zynq-microzed.dts | 2 +-
 arch/arm/boot/dts/zynq-zed.dts      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/zynq-microzed.dts b/arch/arm/boot/dts/zynq-microzed.dts
index aa4a0b6defb8..574ef2276182 100644
--- a/arch/arm/boot/dts/zynq-microzed.dts
+++ b/arch/arm/boot/dts/zynq-microzed.dts
@@ -8,7 +8,7 @@
 
 / {
 	model = "Zynq MicroZED Development Board";
-	compatible = "xlnx,zynq-microzed", "xlnx,zynq-7000";
+	compatible = "avnet,zynq-microzed", "xlnx,zynq-microzed", "xlnx,zynq-7000";
 
 	aliases {
 		ethernet0 = &gem0;
diff --git a/arch/arm/boot/dts/zynq-zed.dts b/arch/arm/boot/dts/zynq-zed.dts
index 53c6883ce1f6..595022487965 100644
--- a/arch/arm/boot/dts/zynq-zed.dts
+++ b/arch/arm/boot/dts/zynq-zed.dts
@@ -8,7 +8,7 @@
 
 / {
 	model = "Zynq Zed Development Board";
-	compatible = "xlnx,zynq-zed", "xlnx,zynq-7000";
+	compatible = "avnet,zynq-zed", "xlnx,zynq-zed", "xlnx,zynq-7000";
 
 	aliases {
 		ethernet0 = &gem0;
-- 
2.18.0
