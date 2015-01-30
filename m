From: moinejf@free.fr (Jean-Francois Moine)
Date: Fri, 30 Jan 2015 07:06:31 +0100
Subject: [PATCH] ARM: dts: mvebu: add ethernet to the cm-a510 board
Message-ID: <mailman.40.1422601366.22887.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables the ethernet device by default, permitting CM-A510
boards to access the network when an ethernet connector is present.

Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
Tested-by: Gabriel Dobato <dobatog@gmail.com>
---
 arch/arm/boot/dts/dove-cm-a510.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/dove-cm-a510.dts b/arch/arm/boot/dts/dove-cm-a510.dts
index 50c0d69..404e983 100644
--- a/arch/arm/boot/dts/dove-cm-a510.dts
+++ b/arch/arm/boot/dts/dove-cm-a510.dts
@@ -21,6 +21,8 @@
 &sdio0 { status = "okay"; };
 &sdio1 { status = "okay"; };
 &sata0 { status = "okay"; };
+&eth { status = "okay"; };
+&mdio { status ="okay";};
 
 &spi0 {
 	status = "okay";
-- 
2.1.4
