From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 11 Apr 2012 16:07:35 -0300
Subject: [PATCH 1/2] ARM: imx6q-arm2: Remove hardcoded mac address
Message-ID: <1334171256-18761-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Do not hardcode the local mac address.

Let bootloader retrieve it.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/boot/dts/imx6q-arm2.dts |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q-arm2.dts b/arch/arm/boot/dts/imx6q-arm2.dts
index ce1c823..04501d1 100644
--- a/arch/arm/boot/dts/imx6q-arm2.dts
+++ b/arch/arm/boot/dts/imx6q-arm2.dts
@@ -29,7 +29,6 @@
 		aips-bus at 02100000 { /* AIPS2 */
 			enet at 02188000 {
 				phy-mode = "rgmii";
-				local-mac-address = [00 04 9F 01 1B 61];
 				status = "okay";
 			};
 
-- 
1.7.1
