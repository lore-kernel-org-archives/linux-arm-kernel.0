From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed,  8 Jul 2015 17:02:37 +0200
Subject: [PATCHv2 8/8] ARM: mvebu: adjust board name and compatible for Armada
 388 GP
In-Reply-To: <1436367757-14202-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1436367757-14202-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1436367757-14202-9-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As the name of the Device Tree file name suggests, the Armada 388 GP
really contains an Armada 388 SoC, so this commit updates the board
name and compatible string in the Device Tree file.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/armada-388-gp.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/armada-388-gp.dts b/arch/arm/boot/dts/armada-388-gp.dts
index 31e5ede..2f6c31f 100644
--- a/arch/arm/boot/dts/armada-388-gp.dts
+++ b/arch/arm/boot/dts/armada-388-gp.dts
@@ -44,8 +44,8 @@
 #include <dt-bindings/gpio/gpio.h>
 
 / {
-	model = "Marvell Armada 385 GP";
-	compatible = "marvell,a385-gp", "marvell,armada388", "marvell,armada380";
+	model = "Marvell Armada 388 DB-88F6820-GP";
+	compatible = "marvell,a388-gp", "marvell,armada388", "marvell,armada380";
 
 	chosen {
 		stdout-path = "serial0:115200n8";
-- 
2.4.5
