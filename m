From: narmstrong@baylibre.com (Neil Armstrong)
Date: Mon, 17 Oct 2016 14:40:01 +0200
Subject: [RFC PATCH 3/3] MAINTAINERS: oxnas: Add new files definitions
In-Reply-To: <20161017124001.23820-1-narmstrong@baylibre.com>
References: <20161017124001.23820-1-narmstrong@baylibre.com>
Message-ID: <20161017124001.23820-4-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the dts files maintained by the OXNAS platform, add a new board.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 71aa5da..9f4bc60 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1444,8 +1444,9 @@ M:	Neil Armstrong <narmstrong@baylibre.com>
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	arch/arm/mach-oxnas/
-F:	arch/arm/boot/dts/oxnas*
+F:	arch/arm/boot/dts/ox8*.dtsi
 F:	arch/arm/boot/dts/wd-mbwe.dts
+F:	arch/arm/boot/dts/cloudengines-pogoplug-series-3.dts
 N:	oxnas
 
 ARM/Mediatek RTC DRIVER
-- 
2.7.0
