From: boris.brezillon@free-electrons.com (Boris BREZILLON)
Date: Tue, 22 Apr 2014 15:12:38 +0200
Subject: [PATCH v3 09/11] ARM: at91/dt: define main xtal frequency of the
 at91sam9261ek board
In-Reply-To: <1398172360-7837-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1398172360-7837-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1398172360-7837-10-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define at91sam9261ek main crystal frequency.

Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
Acked-by: Jean-Jacques HIBLOT <jjhiblot@traphandler.com>
---
 arch/arm/boot/dts/at91sam9261ek.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/at91sam9261ek.dts b/arch/arm/boot/dts/at91sam9261ek.dts
index 2ce527e..c6683ea 100644
--- a/arch/arm/boot/dts/at91sam9261ek.dts
+++ b/arch/arm/boot/dts/at91sam9261ek.dts
@@ -20,6 +20,10 @@
 		reg = <0x20000000 0x4000000>;
 	};
 
+	main_xtal {
+		clock-frequency = <18432000>;
+	};
+
 	clocks {
 		#address-cells = <1>;
 		#size-cells = <1>;
-- 
1.8.3.2
