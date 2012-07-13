From: vipulkumar.samar@st.com (Vipul Kumar Samar)
Date: Fri, 13 Jul 2012 17:51:05 +0530
Subject: [PATCH 2/3] ARM: dts: SPEAr320: Fix compatible string
In-Reply-To: <cover.1342181727.git.vipulkumar.samar@st.com>
References: <cover.1342181727.git.vipulkumar.samar@st.com>
Message-ID: <68769db82768b57876573b9391ee3119fe6ca19e.1342181727.git.vipulkumar.samar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Vipul Kumar Samar <vipulkumar.samar@st.com>
---
 arch/arm/boot/dts/spear320-evb.dts |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/boot/dts/spear320-evb.dts b/arch/arm/boot/dts/spear320-evb.dts
index c13fd1f..4d55b67 100644
--- a/arch/arm/boot/dts/spear320-evb.dts
+++ b/arch/arm/boot/dts/spear320-evb.dts
@@ -16,7 +16,7 @@
 
 / {
 	model = "ST SPEAr300 Evaluation Board";
-	compatible = "st,spear300-evb", "st,spear300";
+	compatible = "st,spear320-evb", "st,spear320";
 	#address-cells = <1>;
 	#size-cells = <1>;
 
-- 
1.7.2.2
