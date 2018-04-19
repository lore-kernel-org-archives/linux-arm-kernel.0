From: amelie.delaunay@st.com (Amelie Delaunay)
Date: Thu, 19 Apr 2018 16:59:56 +0200
Subject: [PATCH 3/3] ARM: dts: stm32: enable USBPHYC on stm32mp157c-ev1
In-Reply-To: <1524149996-27809-1-git-send-email-amelie.delaunay@st.com>
References: <1524149996-27809-1-git-send-email-amelie.delaunay@st.com>
Message-ID: <1524149996-27809-4-git-send-email-amelie.delaunay@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables USBPHYC (USB PHY Controller) on stm32mp157c-ev1.
This enables the two usbphyc usb2 ports.

Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
 arch/arm/boot/dts/stm32mp157c-ev1.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/stm32mp157c-ev1.dts b/arch/arm/boot/dts/stm32mp157c-ev1.dts
index 57e6dbc..070cdad 100644
--- a/arch/arm/boot/dts/stm32mp157c-ev1.dts
+++ b/arch/arm/boot/dts/stm32mp157c-ev1.dts
@@ -19,3 +19,8 @@
 		serial0 = &uart4;
 	};
 };
+
+&usbphyc {
+	status = "okay";
+};
+
-- 
2.7.4
