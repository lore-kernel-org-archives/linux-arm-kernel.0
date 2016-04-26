From: vz@mleia.com (Vladimir Zapolskiy)
Date: Wed, 27 Apr 2016 00:10:30 +0300
Subject: [PATCH v2 3/7] ARM: dts: lpc32xx: ea3250: fix Atmel at24 eeprom vendor
In-Reply-To: <1461705034-355-1-git-send-email-vz@mleia.com>
References: <1461705034-355-1-git-send-email-vz@mleia.com>
Message-ID: <1461705034-355-4-git-send-email-vz@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is no 'at' hardware vendor defined yet, correct vendor prefix
for Atmel is 'atmel'.

Acked-by: Sylvain Lemieux <slemieux.tyco@gmail.com>
Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
---
Changes from v1 to v2:
* added Sylvain's acked-by.
* rebased on top of v2 2/7 changes

 arch/arm/boot/dts/ea3250.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/ea3250.dts b/arch/arm/boot/dts/ea3250.dts
index 9637ac5..52b3ed1 100644
--- a/arch/arm/boot/dts/ea3250.dts
+++ b/arch/arm/boot/dts/ea3250.dts
@@ -162,12 +162,12 @@
 	};
 
 	eeprom at 50 {
-		compatible = "at,24c256";
+		compatible = "atmel,24c256";
 		reg = <0x50>;
 	};
 
 	eeprom at 57 {
-		compatible = "at,24c64";
+		compatible = "atmel,24c64";
 		reg = <0x57>;
 	};
 
-- 
2.1.4
