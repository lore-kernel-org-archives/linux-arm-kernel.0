From: jszhang@marvell.com (Jisheng Zhang)
Date: Mon, 19 Oct 2015 16:49:47 +0800
Subject: [PATCH 6/8] ARM: dts: berlin: enable wdt0 on the Google Chromecast
In-Reply-To: <1445244589-4838-1-git-send-email-jszhang@marvell.com>
References: <1445244589-4838-1-git-send-email-jszhang@marvell.com>
Message-ID: <1445244589-4838-7-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable wdt0 on the Google Chromecast to make use of the watchdog
functionality.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 arch/arm/boot/dts/berlin2cd-google-chromecast.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/berlin2cd-google-chromecast.dts b/arch/arm/boot/dts/berlin2cd-google-chromecast.dts
index 772165a..a17c850 100644
--- a/arch/arm/boot/dts/berlin2cd-google-chromecast.dts
+++ b/arch/arm/boot/dts/berlin2cd-google-chromecast.dts
@@ -85,3 +85,5 @@
 &usb_phy1 { status = "okay"; };
 
 &usb1 { status = "okay"; };
+
+&wdt0 { status = "okay"; };
-- 
2.6.1
