From: jamie@jamieiles.com (Jamie Iles)
Date: Mon, 25 Jul 2011 17:09:59 +0100
Subject: [PATCH 2/3] versatile dt: set the irq-start property for the vic
In-Reply-To: <1311610200-12408-1-git-send-email-jamie@jamieiles.com>
References: <1311610200-12408-1-git-send-email-jamie@jamieiles.com>
Message-ID: <1311610200-12408-3-git-send-email-jamie@jamieiles.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Set an irq-start property for the vic in versatile's dt so that we can
convert the versatile platform to use common vic probing.

Cc: devicetree-discuss at lists.ozlabs.org
Cc: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Jamie Iles <jamie@jamieiles.com>
---
 arch/arm/boot/dts/versatile-ab.dts |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/versatile-ab.dts b/arch/arm/boot/dts/versatile-ab.dts
index 2723804..1c6a1e3 100644
--- a/arch/arm/boot/dts/versatile-ab.dts
+++ b/arch/arm/boot/dts/versatile-ab.dts
@@ -79,6 +79,7 @@
 			interrupt-controller;
 			#interrupt-cells = <1>;
 			reg = <0x10140000 0x1000>;
+			irq-start = <0>;
 		};
 
 		sic: intc at 10003000 {
-- 
1.7.4.1
