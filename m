From: srinivas.kandagatla@st.com (Srinivas Kandagatla)
Date: Thu, 14 Nov 2013 14:53:08 +0000
Subject: [PATCH] ARM: orion5x: Fix typo in device_type property of phy node
Message-ID: <1384440788-3529-1-git-send-email-srinivas.kandagatla@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes a typo for device_type property of phy node.
This can work as of today but once a checks are added in generic code
this typo will stop phy from working.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@st.com>
---
 .../dts/orion5x-lacie-ethernet-disk-mini-v2.dts    |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/boot/dts/orion5x-lacie-ethernet-disk-mini-v2.dts b/arch/arm/boot/dts/orion5x-lacie-ethernet-disk-mini-v2.dts
index aed83de..fcc5bb6 100644
--- a/arch/arm/boot/dts/orion5x-lacie-ethernet-disk-mini-v2.dts
+++ b/arch/arm/boot/dts/orion5x-lacie-ethernet-disk-mini-v2.dts
@@ -58,7 +58,7 @@
 	status = "okay";
 
 	ethphy: ethernet-phy {
-		device-type = "ethernet-phy";
+		device_type = "ethernet-phy";
 		reg = <8>;
 	};
 };
-- 
1.7.6.5
