From: vipulkumar.samar@st.com (Vipul Kumar Samar)
Date: Fri, 13 Jul 2012 17:51:06 +0530
Subject: [PATCH 3/3] ARM: dts: SPEAr320: Fix no. of supported pinmux mode
In-Reply-To: <cover.1342181727.git.vipulkumar.samar@st.com>
References: <cover.1342181727.git.vipulkumar.samar@st.com>
Message-ID: <37075889880066dd96dc2004ac1116c1c17c70cd.1342181727.git.vipulkumar.samar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On spear320 machine no. of supported mode is 4 and by mistake it is programmed
to 3.
Supported modes are:
	AUTO_NET_SMII_MODE
	AUTO_NET_MII_MODE
	AUTO_EXP_MODE
	SMALL_PRINTERS_MODE
	EXTENDED_MODE

Signed-off-by: Vipul Kumar Samar <vipulkumar.samar@st.com>
---
 arch/arm/boot/dts/spear320-evb.dts |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/boot/dts/spear320-evb.dts b/arch/arm/boot/dts/spear320-evb.dts
index 4d55b67..c99f055 100644
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
1.7.2.2
