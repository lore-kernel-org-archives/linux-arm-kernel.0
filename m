From: hdegoede@redhat.com (Hans de Goede)
Date: Fri, 20 Nov 2015 14:47:11 +0100
Subject: [PATCH 2/4] ARM: dts: sun4i: Enable onboard codec used on the iNet1
 tablet
In-Reply-To: <1448027233-750-1-git-send-email-hdegoede@redhat.com>
References: <1448027233-750-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1448027233-750-2-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The iNet1 tablet uses the A10's integrated audio codec, enable it.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun4i-a10-inet1.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/sun4i-a10-inet1.dts b/arch/arm/boot/dts/sun4i-a10-inet1.dts
index df1be08..e09053b 100644
--- a/arch/arm/boot/dts/sun4i-a10-inet1.dts
+++ b/arch/arm/boot/dts/sun4i-a10-inet1.dts
@@ -72,6 +72,10 @@
 	};
 };
 
+&codec {
+	status = "okay";
+};
+
 &cpu0 {
 	cpu-supply = <&reg_dcdc2>;
 };
-- 
2.5.0
