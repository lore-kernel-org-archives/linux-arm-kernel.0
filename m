From: marcel@ziswiler.com (Marcel Ziswiler)
Date: Sat, 10 Feb 2018 02:33:25 +0100
Subject: [PATCH 4/4] ARM: dts: tegra: venice2: remove duplicate pcie-1 node
In-Reply-To: <20180210013326.27771-1-marcel@ziswiler.com>
References: <20180210013326.27771-1-marcel@ziswiler.com>
Message-ID: <20180210013326.27771-5-marcel@ziswiler.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Get rid of duplicate pcie-1 node.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 arch/arm/boot/dts/tegra124-venice2.dts | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm/boot/dts/tegra124-venice2.dts b/arch/arm/boot/dts/tegra124-venice2.dts
index c0469ea149d2..89bcc178994d 100644
--- a/arch/arm/boot/dts/tegra124-venice2.dts
+++ b/arch/arm/boot/dts/tegra124-venice2.dts
@@ -956,11 +956,6 @@
 						nvidia,function = "usb3-ss";
 						status = "okay";
 					};
-
-					pcie-1 {
-						nvidia,function = "usb3-ss";
-						status = "okay";
-					};
 				};
 			};
 		};
-- 
2.14.3
