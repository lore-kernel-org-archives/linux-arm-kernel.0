From: oskari@lemmela.net (Oskari Lemmela)
Date: Mon,  8 Oct 2018 21:19:05 +0300
Subject: [PATCH v3 4/7] arm64: dts: allwinner: a64: sopine: enable power
 supplies
In-Reply-To: <20181008181908.9456-1-oskari@lemmela.net>
References: <20181008181908.9456-1-oskari@lemmela.net>
Message-ID: <20181008181908.9456-5-oskari@lemmela.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sopine baseboard have ACIN and battery connectors.

Signed-off-by: Oskari Lemmela <oskari@lemmela.net>
---
 .../boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts    | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
index c21f2331add6..335cf2263d19 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
@@ -69,6 +69,14 @@
 	};
 };
 
+&ac_power_supply {
+	status = "okay";
+};
+
+&battery_power_supply {
+	status = "okay";
+};
+
 &ehci0 {
 	status = "okay";
 };
-- 
2.17.1
