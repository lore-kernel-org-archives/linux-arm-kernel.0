From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Tue, 13 Oct 2015 00:12:30 +0300
Subject: [PATCH 01/37] ARM: dts: am437x-gp-evm: Remove unneeded regulator
 property
In-Reply-To: <1444684386-17094-1-git-send-email-laurent.pinchart@ideasonboard.com>
References: <1444684386-17094-1-git-send-email-laurent.pinchart@ideasonboard.com>
Message-ID: <1444684386-17094-2-git-send-email-laurent.pinchart@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The enable-active-high regulator property only makes sense when an
enable GPIO is specified. Remove it.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 arch/arm/boot/dts/am437x-gp-evm.dts | 1 -
 1 file changed, 1 deletion(-)

Cc: linux-omap at vger.kernel.org
Cc: Benoit Cousson <bcousson@baylibre.com>
Cc: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/boot/dts/am437x-gp-evm.dts b/arch/arm/boot/dts/am437x-gp-evm.dts
index 84aa30c3235a..a3cd413aebf0 100644
--- a/arch/arm/boot/dts/am437x-gp-evm.dts
+++ b/arch/arm/boot/dts/am437x-gp-evm.dts
@@ -29,7 +29,6 @@
 		regulator-name = "vmmcsd_fixed";
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
-		enable-active-high;
 	};
 
 	vtt_fixed: fixedregulator-vtt {
-- 
2.4.9
