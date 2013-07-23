From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Tue, 23 Jul 2013 10:31:29 -0300
Subject: [PATCH v8 25/28] ARM: kirkwood: Use the preprocessor on device tree
 files
In-Reply-To: <1374586292-4941-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1374586292-4941-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1374586292-4941-26-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 arch/arm/boot/dts/kirkwood-cloudbox.dts                | 4 ++--
 arch/arm/boot/dts/kirkwood-db-88f6281.dts              | 4 ++--
 arch/arm/boot/dts/kirkwood-db-88f6282.dts              | 4 ++--
 arch/arm/boot/dts/kirkwood-db.dtsi                     | 2 +-
 arch/arm/boot/dts/kirkwood-dns320.dts                  | 2 +-
 arch/arm/boot/dts/kirkwood-dns325.dts                  | 2 +-
 arch/arm/boot/dts/kirkwood-dnskw.dtsi                  | 4 ++--
 arch/arm/boot/dts/kirkwood-dockstar.dts                | 4 ++--
 arch/arm/boot/dts/kirkwood-dreamplug.dts               | 4 ++--
 arch/arm/boot/dts/kirkwood-goflexnet.dts               | 4 ++--
 arch/arm/boot/dts/kirkwood-guruplug-server-plus.dts    | 4 ++--
 arch/arm/boot/dts/kirkwood-ib62x0.dts                  | 4 ++--
 arch/arm/boot/dts/kirkwood-iconnect.dts                | 4 ++--
 arch/arm/boot/dts/kirkwood-iomega_ix2_200.dts          | 4 ++--
 arch/arm/boot/dts/kirkwood-is2.dts                     | 2 +-
 arch/arm/boot/dts/kirkwood-km_kirkwood.dts             | 4 ++--
 arch/arm/boot/dts/kirkwood-lschlv2.dts                 | 2 +-
 arch/arm/boot/dts/kirkwood-lsxhl.dts                   | 2 +-
 arch/arm/boot/dts/kirkwood-lsxl.dtsi                   | 4 ++--
 arch/arm/boot/dts/kirkwood-mplcec4.dts                 | 4 ++--
 arch/arm/boot/dts/kirkwood-netgear_readynas_duo_v2.dts | 4 ++--
 arch/arm/boot/dts/kirkwood-ns2-common.dtsi             | 4 ++--
 arch/arm/boot/dts/kirkwood-ns2.dts                     | 2 +-
 arch/arm/boot/dts/kirkwood-ns2lite.dts                 | 2 +-
 arch/arm/boot/dts/kirkwood-ns2max.dts                  | 2 +-
 arch/arm/boot/dts/kirkwood-ns2mini.dts                 | 2 +-
 arch/arm/boot/dts/kirkwood-nsa310.dts                  | 4 ++--
 arch/arm/boot/dts/kirkwood-openblocks_a6.dts           | 4 ++--
 arch/arm/boot/dts/kirkwood-sheevaplug-common.dtsi      | 4 ++--
 arch/arm/boot/dts/kirkwood-sheevaplug-esata.dts        | 2 +-
 arch/arm/boot/dts/kirkwood-sheevaplug.dts              | 2 +-
 arch/arm/boot/dts/kirkwood-topkick.dts                 | 4 ++--
 arch/arm/boot/dts/kirkwood-ts219-6281.dts              | 6 +++---
 arch/arm/boot/dts/kirkwood-ts219-6282.dts              | 6 +++---
 34 files changed, 58 insertions(+), 58 deletions(-)

diff --git a/arch/arm/boot/dts/kirkwood-cloudbox.dts b/arch/arm/boot/dts/kirkwood-cloudbox.dts
index 00c48d2..9bf139c 100644
--- a/arch/arm/boot/dts/kirkwood-cloudbox.dts
+++ b/arch/arm/boot/dts/kirkwood-cloudbox.dts
@@ -1,7 +1,7 @@
 /dts-v1/;
 
-/include/ "kirkwood.dtsi"
-/include/ "kirkwood-6281.dtsi"
+#include "kirkwood.dtsi"
+#include "kirkwood-6281.dtsi"
 
 / {
 	model = "LaCie CloudBox";
diff --git a/arch/arm/boot/dts/kirkwood-db-88f6281.dts b/arch/arm/boot/dts/kirkwood-db-88f6281.dts
index 9d777ed..f420cbe 100644
--- a/arch/arm/boot/dts/kirkwood-db-88f6281.dts
+++ b/arch/arm/boot/dts/kirkwood-db-88f6281.dts
@@ -11,8 +11,8 @@
 
 /dts-v1/;
 
-/include/ "kirkwood-db.dtsi"
-/include/ "kirkwood-6281.dtsi"
+#include "kirkwood-db.dtsi"
+#include "kirkwood-6281.dtsi"
 
 / {
 	model = "Marvell DB-88F6281-BP Development Board";
diff --git a/arch/arm/boot/dts/kirkwood-db-88f6282.dts b/arch/arm/boot/dts/kirkwood-db-88f6282.dts
index f4c8528..c5df866 100644
--- a/arch/arm/boot/dts/kirkwood-db-88f6282.dts
+++ b/arch/arm/boot/dts/kirkwood-db-88f6282.dts
@@ -11,8 +11,8 @@
 
 /dts-v1/;
 
-/include/ "kirkwood-db.dtsi"
-/include/ "kirkwood-6282.dtsi"
+#include "kirkwood-db.dtsi"
+#include "kirkwood-6282.dtsi"
 
 / {
 	model = "Marvell DB-88F6282-BP Development Board";
diff --git a/arch/arm/boot/dts/kirkwood-db.dtsi b/arch/arm/boot/dts/kirkwood-db.dtsi
index c87cfb8..29bd98e 100644
--- a/arch/arm/boot/dts/kirkwood-db.dtsi
+++ b/arch/arm/boot/dts/kirkwood-db.dtsi
@@ -12,7 +12,7 @@
  * and 6282 variants of the Marvell Kirkwood Development Board.
  */
 
-/include/ "kirkwood.dtsi"
+#include "kirkwood.dtsi"
 
 / {
 	memory {
diff --git a/arch/arm/boot/dts/kirkwood-dns320.dts b/arch/arm/boot/dts/kirkwood-dns320.dts
index 14d4cee..e112ca6 100644
--- a/arch/arm/boot/dts/kirkwood-dns320.dts
+++ b/arch/arm/boot/dts/kirkwood-dns320.dts
@@ -1,6 +1,6 @@
 /dts-v1/;
 
-/include/ "kirkwood-dnskw.dtsi"
+#include "kirkwood-dnskw.dtsi"
 
 / {
 	model = "D-Link DNS-320 NAS (Rev A1)";
diff --git a/arch/arm/boot/dts/kirkwood-dns325.dts b/arch/arm/boot/dts/kirkwood-dns325.dts
index 6387257..5119fb8 100644
--- a/arch/arm/boot/dts/kirkwood-dns325.dts
+++ b/arch/arm/boot/dts/kirkwood-dns325.dts
@@ -1,6 +1,6 @@
 /dts-v1/;
 
-/include/ "kirkwood-dnskw.dtsi"
+#include "kirkwood-dnskw.dtsi"
 
 / {
 	model = "D-Link DNS-325 NAS (Rev A1)";
diff --git a/arch/arm/boot/dts/kirkwood-dnskw.dtsi b/arch/arm/boot/dts/kirkwood-dnskw.dtsi
index 0afe1d0..2e04284 100644
--- a/arch/arm/boot/dts/kirkwood-dnskw.dtsi
+++ b/arch/arm/boot/dts/kirkwood-dnskw.dtsi
@@ -1,5 +1,5 @@
-/include/ "kirkwood.dtsi"
-/include/ "kirkwood-6281.dtsi"
+#include "kirkwood.dtsi"
+#include "kirkwood-6281.dtsi"
 
 / {
 	model = "D-Link DNS NASes (kirkwood-based)";
diff --git a/arch/arm/boot/dts/kirkwood-dockstar.dts b/arch/arm/boot/dts/kirkwood-dockstar.dts
index 7714742..4387ae8 100644
--- a/arch/arm/boot/dts/kirkwood-dockstar.dts
+++ b/arch/arm/boot/dts/kirkwood-dockstar.dts
@@ -1,7 +1,7 @@
 /dts-v1/;
 
-/include/ "kirkwood.dtsi"
-/include/ "kirkwood-6281.dtsi"
+#include "kirkwood.dtsi"
+#include "kirkwood-6281.dtsi"
 
 / {
 	model = "Seagate FreeAgent Dockstar";
diff --git a/arch/arm/boot/dts/kirkwood-dreamplug.dts b/arch/arm/boot/dts/kirkwood-dreamplug.dts
index 36c7ba3..c628378 100644
--- a/arch/arm/boot/dts/kirkwood-dreamplug.dts
+++ b/arch/arm/boot/dts/kirkwood-dreamplug.dts
@@ -1,7 +1,7 @@
 /dts-v1/;
 
-/include/ "kirkwood.dtsi"
-/include/ "kirkwood-6281.dtsi"
+#include "kirkwood.dtsi"
+#include "kirkwood-6281.dtsi"
 
 / {
 	model = "Globalscale Technologies Dreamplug";
diff --git a/arch/arm/boot/dts/kirkwood-goflexnet.dts b/arch/arm/boot/dts/kirkwood-goflexnet.dts
index 31caa64..e571180 100644
--- a/arch/arm/boot/dts/kirkwood-goflexnet.dts
+++ b/arch/arm/boot/dts/kirkwood-goflexnet.dts
@@ -1,7 +1,7 @@
 /dts-v1/;
 
-/include/ "kirkwood.dtsi"
-/include/ "kirkwood-6281.dtsi"
+#include "kirkwood.dtsi"
+#include "kirkwood-6281.dtsi"
 
 / {
 	model = "Seagate GoFlex Net";
diff --git a/arch/arm/boot/dts/kirkwood-guruplug-server-plus.dts b/arch/arm/boot/dts/kirkwood-guruplug-server-plus.dts
index 1e642f3..2c5673a 100644
--- a/arch/arm/boot/dts/kirkwood-guruplug-server-plus.dts
+++ b/arch/arm/boot/dts/kirkwood-guruplug-server-plus.dts
@@ -1,7 +1,7 @@
 /dts-v1/;
 
-/include/ "kirkwood.dtsi"
-/include/ "kirkwood-6281.dtsi"
+#include "kirkwood.dtsi"
+#include "kirkwood-6281.dtsi"
 
 / {
 	model = "Globalscale Technologies Guruplug Server Plus";
diff --git a/arch/arm/boot/dts/kirkwood-ib62x0.dts b/arch/arm/boot/dts/kirkwood-ib62x0.dts
index 20c4b08..158161f 100644
--- a/arch/arm/boot/dts/kirkwood-ib62x0.dts
+++ b/arch/arm/boot/dts/kirkwood-ib62x0.dts
@@ -1,7 +1,7 @@
 /dts-v1/;
 
-/include/ "kirkwood.dtsi"
-/include/ "kirkwood-6281.dtsi"
+#include "kirkwood.dtsi"
+#include "kirkwood-6281.dtsi"
 
 / {
 	model = "RaidSonic ICY BOX IB-NAS62x0 (Rev B)";
diff --git a/arch/arm/boot/dts/kirkwood-iconnect.dts b/arch/arm/boot/dts/kirkwood-iconnect.dts
index 441204e..1a98487 100644
--- a/arch/arm/boot/dts/kirkwood-iconnect.dts
+++ b/arch/arm/boot/dts/kirkwood-iconnect.dts
@@ -1,7 +1,7 @@
 /dts-v1/;
 
-/include/ "kirkwood.dtsi"
-/include/ "kirkwood-6281.dtsi"
+#include "kirkwood.dtsi"
+#include "kirkwood-6281.dtsi"
 
 / {
 	model = "Iomega Iconnect";
diff --git a/arch/arm/boot/dts/kirkwood-iomega_ix2_200.dts b/arch/arm/boot/dts/kirkwood-iomega_ix2_200.dts
index 00a7bfe..fd7f053 100644
--- a/arch/arm/boot/dts/kirkwood-iomega_ix2_200.dts
+++ b/arch/arm/boot/dts/kirkwood-iomega_ix2_200.dts
@@ -1,7 +1,7 @@
 /dts-v1/;
 
-/include/ "kirkwood.dtsi"
-/include/ "kirkwood-6281.dtsi"
+#include "kirkwood.dtsi"
+#include "kirkwood-6281.dtsi"
 
 / {
 	model = "Iomega StorCenter ix2-200";
diff --git a/arch/arm/boot/dts/kirkwood-is2.dts b/arch/arm/boot/dts/kirkwood-is2.dts
index c3f036b..bd88a23 100644
--- a/arch/arm/boot/dts/kirkwood-is2.dts
+++ b/arch/arm/boot/dts/kirkwood-is2.dts
@@ -1,6 +1,6 @@
 /dts-v1/;
 
-/include/ "kirkwood-ns2-common.dtsi"
+#include "kirkwood-ns2-common.dtsi"
 
 / {
 	model = "LaCie Internet Space v2";
diff --git a/arch/arm/boot/dts/kirkwood-km_kirkwood.dts b/arch/arm/boot/dts/kirkwood-km_kirkwood.dts
index 5d9f5ea..b071d37 100644
--- a/arch/arm/boot/dts/kirkwood-km_kirkwood.dts
+++ b/arch/arm/boot/dts/kirkwood-km_kirkwood.dts
@@ -1,7 +1,7 @@
 /dts-v1/;
 
-/include/ "kirkwood.dtsi"
-/include/ "kirkwood-98dx4122.dtsi"
+#include "kirkwood.dtsi"
+#include "kirkwood-98dx4122.dtsi"
 
 / {
 	model = "Keymile Kirkwood Reference Design";
diff --git a/arch/arm/boot/dts/kirkwood-lschlv2.dts b/arch/arm/boot/dts/kirkwood-lschlv2.dts
index 9f55d95..e2fa368 100644
--- a/arch/arm/boot/dts/kirkwood-lschlv2.dts
+++ b/arch/arm/boot/dts/kirkwood-lschlv2.dts
@@ -1,6 +1,6 @@
 /dts-v1/;
 
-/include/ "kirkwood-lsxl.dtsi"
+#include "kirkwood-lsxl.dtsi"
 
 / {
 	model = "Buffalo Linkstation LS-CHLv2";
diff --git a/arch/arm/boot/dts/kirkwood-lsxhl.dts b/arch/arm/boot/dts/kirkwood-lsxhl.dts
index 5c84c11..8d89cdf 100644
--- a/arch/arm/boot/dts/kirkwood-lsxhl.dts
+++ b/arch/arm/boot/dts/kirkwood-lsxhl.dts
@@ -1,6 +1,6 @@
 /dts-v1/;
 
-/include/ "kirkwood-lsxl.dtsi"
+#include "kirkwood-lsxl.dtsi"
 
 / {
 	model = "Buffalo Linkstation LS-XHL";
diff --git a/arch/arm/boot/dts/kirkwood-lsxl.dtsi b/arch/arm/boot/dts/kirkwood-lsxl.dtsi
index 31b17f5..f7e247c 100644
--- a/arch/arm/boot/dts/kirkwood-lsxl.dtsi
+++ b/arch/arm/boot/dts/kirkwood-lsxl.dtsi
@@ -1,5 +1,5 @@
-/include/ "kirkwood.dtsi"
-/include/ "kirkwood-6281.dtsi"
+#include "kirkwood.dtsi"
+#include "kirkwood-6281.dtsi"
 
 / {
 	chosen {
diff --git a/arch/arm/boot/dts/kirkwood-mplcec4.dts b/arch/arm/boot/dts/kirkwood-mplcec4.dts
index 6179333..382ad99 100644
--- a/arch/arm/boot/dts/kirkwood-mplcec4.dts
+++ b/arch/arm/boot/dts/kirkwood-mplcec4.dts
@@ -1,7 +1,7 @@
 /dts-v1/;
 
-/include/ "kirkwood.dtsi"
-/include/ "kirkwood-6281.dtsi"
+#include "kirkwood.dtsi"
+#include "kirkwood-6281.dtsi"
 
 / {
 	model = "MPL CEC4";
diff --git a/arch/arm/boot/dts/kirkwood-netgear_readynas_duo_v2.dts b/arch/arm/boot/dts/kirkwood-netgear_readynas_duo_v2.dts
index ad6ade7..8be68bd 100644
--- a/arch/arm/boot/dts/kirkwood-netgear_readynas_duo_v2.dts
+++ b/arch/arm/boot/dts/kirkwood-netgear_readynas_duo_v2.dts
@@ -1,7 +1,7 @@
 /dts-v1/;
 
-/include/ "kirkwood.dtsi"
-/include/ "kirkwood-6282.dtsi"
+#include "kirkwood.dtsi"
+#include "kirkwood-6282.dtsi"
 
 / {
 	model = "NETGEAR ReadyNAS Duo v2";
diff --git a/arch/arm/boot/dts/kirkwood-ns2-common.dtsi b/arch/arm/boot/dts/kirkwood-ns2-common.dtsi
index 2afac04..d0fb34d 100644
--- a/arch/arm/boot/dts/kirkwood-ns2-common.dtsi
+++ b/arch/arm/boot/dts/kirkwood-ns2-common.dtsi
@@ -1,5 +1,5 @@
-/include/ "kirkwood.dtsi"
-/include/ "kirkwood-6281.dtsi"
+#include "kirkwood.dtsi"
+#include "kirkwood-6281.dtsi"
 
 / {
 	chosen {
diff --git a/arch/arm/boot/dts/kirkwood-ns2.dts b/arch/arm/boot/dts/kirkwood-ns2.dts
index b50e93d..0599f3c 100644
--- a/arch/arm/boot/dts/kirkwood-ns2.dts
+++ b/arch/arm/boot/dts/kirkwood-ns2.dts
@@ -1,6 +1,6 @@
 /dts-v1/;
 
-/include/ "kirkwood-ns2-common.dtsi"
+#include "kirkwood-ns2-common.dtsi"
 
 / {
 	model = "LaCie Network Space v2";
diff --git a/arch/arm/boot/dts/kirkwood-ns2lite.dts b/arch/arm/boot/dts/kirkwood-ns2lite.dts
index af8259f..b0e1798 100644
--- a/arch/arm/boot/dts/kirkwood-ns2lite.dts
+++ b/arch/arm/boot/dts/kirkwood-ns2lite.dts
@@ -1,6 +1,6 @@
 /dts-v1/;
 
-/include/ "kirkwood-ns2-common.dtsi"
+#include "kirkwood-ns2-common.dtsi"
 
 / {
 	model = "LaCie Network Space Lite v2";
diff --git a/arch/arm/boot/dts/kirkwood-ns2max.dts b/arch/arm/boot/dts/kirkwood-ns2max.dts
index 85f24d2..d4f6a58 100644
--- a/arch/arm/boot/dts/kirkwood-ns2max.dts
+++ b/arch/arm/boot/dts/kirkwood-ns2max.dts
@@ -1,6 +1,6 @@
 /dts-v1/;
 
-/include/ "kirkwood-ns2-common.dtsi"
+#include "kirkwood-ns2-common.dtsi"
 
 / {
 	model = "LaCie Network Space Max v2";
diff --git a/arch/arm/boot/dts/kirkwood-ns2mini.dts b/arch/arm/boot/dts/kirkwood-ns2mini.dts
index 329e530..f30e05a 100644
--- a/arch/arm/boot/dts/kirkwood-ns2mini.dts
+++ b/arch/arm/boot/dts/kirkwood-ns2mini.dts
@@ -1,6 +1,6 @@
 /dts-v1/;
 
-/include/ "kirkwood-ns2-common.dtsi"
+#include "kirkwood-ns2-common.dtsi"
 
 / {
 	/* This machine is embedded in the first LaCie CloudBox product. */
diff --git a/arch/arm/boot/dts/kirkwood-nsa310.dts b/arch/arm/boot/dts/kirkwood-nsa310.dts
index 6900359..8fd683c 100644
--- a/arch/arm/boot/dts/kirkwood-nsa310.dts
+++ b/arch/arm/boot/dts/kirkwood-nsa310.dts
@@ -1,7 +1,7 @@
 /dts-v1/;
 
-/include/ "kirkwood.dtsi"
-/include/ "kirkwood-6281.dtsi"
+#include "kirkwood.dtsi"
+#include "kirkwood-6281.dtsi"
 
 / {
 	model = "ZyXEL NSA310";
diff --git a/arch/arm/boot/dts/kirkwood-openblocks_a6.dts b/arch/arm/boot/dts/kirkwood-openblocks_a6.dts
index 38dc851..365b792 100644
--- a/arch/arm/boot/dts/kirkwood-openblocks_a6.dts
+++ b/arch/arm/boot/dts/kirkwood-openblocks_a6.dts
@@ -1,7 +1,7 @@
 /dts-v1/;
 
-/include/ "kirkwood.dtsi"
-/include/ "kirkwood-6282.dtsi"
+#include "kirkwood.dtsi"
+#include "kirkwood-6282.dtsi"
 
 / {
 	model = "Plat'Home OpenBlocksA6";
diff --git a/arch/arm/boot/dts/kirkwood-sheevaplug-common.dtsi b/arch/arm/boot/dts/kirkwood-sheevaplug-common.dtsi
index f7143f1..0cc5f26 100644
--- a/arch/arm/boot/dts/kirkwood-sheevaplug-common.dtsi
+++ b/arch/arm/boot/dts/kirkwood-sheevaplug-common.dtsi
@@ -6,8 +6,8 @@
  * Licensed under GPLv2
  */
 
-/include/ "kirkwood.dtsi"
-/include/ "kirkwood-6281.dtsi"
+#include "kirkwood.dtsi"
+#include "kirkwood-6281.dtsi"
 
 / {
 	memory {
diff --git a/arch/arm/boot/dts/kirkwood-sheevaplug-esata.dts b/arch/arm/boot/dts/kirkwood-sheevaplug-esata.dts
index f620ce4..eac6a21 100644
--- a/arch/arm/boot/dts/kirkwood-sheevaplug-esata.dts
+++ b/arch/arm/boot/dts/kirkwood-sheevaplug-esata.dts
@@ -8,7 +8,7 @@
 
 /dts-v1/;
 
-/include/ "kirkwood-sheevaplug-common.dtsi"
+#include "kirkwood-sheevaplug-common.dtsi"
 
 / {
 	model = "Globalscale Technologies eSATA SheevaPlug";
diff --git a/arch/arm/boot/dts/kirkwood-sheevaplug.dts b/arch/arm/boot/dts/kirkwood-sheevaplug.dts
index bf1dff2..bb61918 100644
--- a/arch/arm/boot/dts/kirkwood-sheevaplug.dts
+++ b/arch/arm/boot/dts/kirkwood-sheevaplug.dts
@@ -8,7 +8,7 @@
 
 /dts-v1/;
 
-/include/ "kirkwood-sheevaplug-common.dtsi"
+#include "kirkwood-sheevaplug-common.dtsi"
 
 / {
 	model = "Globalscale Technologies SheevaPlug";
diff --git a/arch/arm/boot/dts/kirkwood-topkick.dts b/arch/arm/boot/dts/kirkwood-topkick.dts
index f2052d7..974f1e0 100644
--- a/arch/arm/boot/dts/kirkwood-topkick.dts
+++ b/arch/arm/boot/dts/kirkwood-topkick.dts
@@ -1,7 +1,7 @@
 /dts-v1/;
 
-/include/ "kirkwood.dtsi"
-/include/ "kirkwood-6282.dtsi"
+#include "kirkwood.dtsi"
+#include "kirkwood-6282.dtsi"
 
 / {
 	model = "Univeral Scientific Industrial Co. Topkick-1281P2";
diff --git a/arch/arm/boot/dts/kirkwood-ts219-6281.dts b/arch/arm/boot/dts/kirkwood-ts219-6281.dts
index 6dd1038..3867ae3 100644
--- a/arch/arm/boot/dts/kirkwood-ts219-6281.dts
+++ b/arch/arm/boot/dts/kirkwood-ts219-6281.dts
@@ -1,8 +1,8 @@
 /dts-v1/;
 
-/include/ "kirkwood.dtsi"
-/include/ "kirkwood-6281.dtsi"
-/include/ "kirkwood-ts219.dtsi"
+#include "kirkwood.dtsi"
+#include "kirkwood-6281.dtsi"
+#include "kirkwood-ts219.dtsi"
 
 / {
 	ocp at f1000000 {
diff --git a/arch/arm/boot/dts/kirkwood-ts219-6282.dts b/arch/arm/boot/dts/kirkwood-ts219-6282.dts
index 6fdc5ff..7d6cc86 100644
--- a/arch/arm/boot/dts/kirkwood-ts219-6282.dts
+++ b/arch/arm/boot/dts/kirkwood-ts219-6282.dts
@@ -1,8 +1,8 @@
 /dts-v1/;
 
-/include/ "kirkwood.dtsi"
-/include/ "kirkwood-6282.dtsi"
-/include/ "kirkwood-ts219.dtsi"
+#include "kirkwood.dtsi"
+#include "kirkwood-6282.dtsi"
+#include "kirkwood-ts219.dtsi"
 
 / {
 	ocp at f1000000 {
-- 
1.8.1.5
