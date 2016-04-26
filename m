From: vz@mleia.com (Vladimir Zapolskiy)
Date: Tue, 26 Apr 2016 03:37:26 +0300
Subject: [PATCH 3/7] ARM: dts: lpc32xx: ea3250: fix Atmel at24 eeprom vendor
In-Reply-To: <1461631050-10479-1-git-send-email-vz@mleia.com>
References: <1461631050-10479-1-git-send-email-vz@mleia.com>
Message-ID: <1461631050-10479-4-git-send-email-vz@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is no 'at' hardware vendor defined yet, correct vendor prefix
for Atmel is 'atmel'.

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
---
 arch/arm/boot/dts/ea3250.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/ea3250.dts b/arch/arm/boot/dts/ea3250.dts
index 58bcda9..12e78c6 100644
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
