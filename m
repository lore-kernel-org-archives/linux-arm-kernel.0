From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Fri, 22 Jun 2012 19:02:11 +0530
Subject: [RFC PATCH 02/10] arm/dts: omap: Add omap-usb2 dt data
In-Reply-To: <1340371939-23572-1-git-send-email-kishon@ti.com>
References: <1340371939-23572-1-git-send-email-kishon@ti.com>
Message-ID: <1340371939-23572-3-git-send-email-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add omap-usb2 data node in omap4 device tree file.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/omap4.dtsi |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index 9082191..e670394 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -291,6 +291,10 @@
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ti,hwmods = "ocp2scp_usb_phy";
+			usb2phy at 0x4a0ad080 {
+				compatible = "ti,omap-usb2";
+				reg = <0x4a0ad080 0x58>;
+			};
 		};
 	};
 };
-- 
1.7.5.4
