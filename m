From: narmstrong@baylibre.com (Neil Armstrong)
Date: Wed,  2 Nov 2016 15:18:50 +0100
Subject: [PATCH v2 2/2] MAINTAINERS: oxnas: Add new files definitions
In-Reply-To: <20161102141850.25164-1-narmstrong@baylibre.com>
References: <20161102141850.25164-1-narmstrong@baylibre.com>
Message-ID: <20161102141850.25164-3-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the dts files maintained by the OXNAS platform, add a new board.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1cd38a7..29d8853 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1478,8 +1478,9 @@ L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
 L:	linux-oxnas at lists.tuxfamily.org (moderated for non-subscribers)
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
