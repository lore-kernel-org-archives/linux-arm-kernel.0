From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Fri, 14 Nov 2014 16:26:03 +0100
Subject: [PATCH v7 13/13] ARM: dts: berlin: enable USB on the Google Chromecast
In-Reply-To: <1415978763-27345-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1415978763-27345-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <1415978763-27345-14-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

Enable usb1 on Google Chromecast which is connected to micro-USB
plug used for external power supply, too.

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
---
 arch/arm/boot/dts/berlin2cd-google-chromecast.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/berlin2cd-google-chromecast.dts b/arch/arm/boot/dts/berlin2cd-google-chromecast.dts
index bcd81ffc495d..5c42c3bfb613 100644
--- a/arch/arm/boot/dts/berlin2cd-google-chromecast.dts
+++ b/arch/arm/boot/dts/berlin2cd-google-chromecast.dts
@@ -27,3 +27,7 @@
 };
 
 &uart0 { status = "okay"; };
+
+&usb_phy1 { status = "okay"; };
+
+&usb1 { status = "okay"; };
-- 
2.1.0
