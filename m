From: baruch@tkos.co.il (Baruch Siach)
Date: Mon,  6 Jul 2015 14:41:45 +0300
Subject: [PATCH 3/4] ARM: digicolor: dts: use stdout-path for console
 configuration
In-Reply-To: <cover.1436182214.git.baruch@tkos.co.il>
References: <cover.1436182214.git.baruch@tkos.co.il>
Message-ID: <1d8d09047cfb92d6555fc5453c137a3e5745cade.1436182214.git.baruch@tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 arch/arm/boot/dts/cx92755_equinox.dts | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/cx92755_equinox.dts b/arch/arm/boot/dts/cx92755_equinox.dts
index 90d52cc416dc..5da00806c41e 100644
--- a/arch/arm/boot/dts/cx92755_equinox.dts
+++ b/arch/arm/boot/dts/cx92755_equinox.dts
@@ -64,8 +64,7 @@
 	};
 
 	chosen {
-		bootargs = "console=ttyS0,115200";
-		stdout-path = &uart0;
+		stdout-path = "serial0:115200n8";
 	};
 };
 
-- 
2.1.4
