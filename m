From: vipulkumar.samar@st.com (Vipul Kumar Samar)
Date: Tue, 17 Jul 2012 12:39:23 +0530
Subject: [PATCH v2 2/2] ARM: dts: SPEAr320: Boot the board in EXTENDED_MODE
In-Reply-To: <004cd5118cabfe44e9d5b256684122016a1728f4.1342508737.git.vipulkumar.samar@st.com>
References: <004cd5118cabfe44e9d5b256684122016a1728f4.1342508737.git.vipulkumar.samar@st.com>
Message-ID: <4d27fa9cf26c74bec934d20701c2d1712dee369a.1342508737.git.vipulkumar.samar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On spear320 machine no. of supported mode are:
	AUTO_NET_SMII_MODE
	AUTO_NET_MII_MODE
	AUTO_EXP_MODE
	SMALL_PRINTERS_MODE
	EXTENDED_MODE
This patch is to configure and boot the machine in EXTENDED_MODE.

Signed-off-by: Vipul Kumar Samar <vipulkumar.samar@st.com>
---
 arch/arm/boot/dts/spear320-evb.dts |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/boot/dts/spear320-evb.dts b/arch/arm/boot/dts/spear320-evb.dts
index f28bea8..e4e912f 100644
--- a/arch/arm/boot/dts/spear320-evb.dts
+++ b/arch/arm/boot/dts/spear320-evb.dts
@@ -26,7 +26,7 @@
 
 	ahb {
 		pinmux at b3000000 {
-			st,pinmux-mode = <3>;
+			st,pinmux-mode = <4>;
 			pinctrl-names = "default";
 			pinctrl-0 = <&state_default>;
 
-- 
1.7.3.4
