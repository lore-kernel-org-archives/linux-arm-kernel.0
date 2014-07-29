From: dianders@chromium.org (Doug Anderson)
Date: Tue, 29 Jul 2014 16:24:33 -0700
Subject: [PATCH 3/3] ARM: dts: Enable USB host0 (EHCI) on rk3288-evb
In-Reply-To: <1406676273-20701-1-git-send-email-dianders@chromium.org>
References: <1406676273-20701-1-git-send-email-dianders@chromium.org>
Message-ID: <1406676273-20701-4-git-send-email-dianders@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is the top USB port on the evb (the one closest to the Ethernet
connector).

Signed-off-by: Doug Anderson <dianders@chromium.org>
Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
---
 arch/arm/boot/dts/rk3288-evb.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288-evb.dtsi b/arch/arm/boot/dts/rk3288-evb.dtsi
index efd625e..fcdc64e 100644
--- a/arch/arm/boot/dts/rk3288-evb.dtsi
+++ b/arch/arm/boot/dts/rk3288-evb.dtsi
@@ -90,3 +90,7 @@
 		};
 	};
 };
+
+&usb_host0_ehci {
+	status = "okay";
+};
-- 
2.0.0.526.g5318336
