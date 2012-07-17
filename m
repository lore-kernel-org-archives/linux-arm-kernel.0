From: vipulkumar.samar@st.com (Vipul Kumar Samar)
Date: Tue, 17 Jul 2012 12:39:22 +0530
Subject: [PATCH v2 1/2] ARM: dts: SPEAr320: Fix compatible string
Message-ID: <004cd5118cabfe44e9d5b256684122016a1728f4.1342508737.git.vipulkumar.samar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Vipul Kumar Samar <vipulkumar.samar@st.com>
---
 arch/arm/boot/dts/spear320-evb.dts |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/spear320-evb.dts b/arch/arm/boot/dts/spear320-evb.dts
index c13fd1f..f28bea8 100644
--- a/arch/arm/boot/dts/spear320-evb.dts
+++ b/arch/arm/boot/dts/spear320-evb.dts
@@ -15,8 +15,8 @@
 /include/ "spear320.dtsi"
 
 / {
-	model = "ST SPEAr300 Evaluation Board";
-	compatible = "st,spear300-evb", "st,spear300";
+	model = "ST SPEAr320 Evaluation Board";
+	compatible = "st,spear320-evb", "st,spear320";
 	#address-cells = <1>;
 	#size-cells = <1>;
 
-- 
1.7.3.4
