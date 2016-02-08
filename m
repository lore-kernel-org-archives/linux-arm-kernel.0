From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon,  8 Feb 2016 18:14:18 +0100
Subject: [PATCH v3 10/12] MAINTAINERS: Extend dts entry for ARM64 mvebu files
In-Reply-To: <1454951660-13289-1-git-send-email-gregory.clement@free-electrons.com>
References: <1454951660-13289-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1454951660-13289-11-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Extend the mvebu entry to ARM64 device tree sources.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Reviewed-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 30aca4aa5467..ad49b62c5abc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1279,6 +1279,7 @@ F:	arch/arm/mach-mvebu/
 F:	drivers/rtc/rtc-armada38x.c
 F:	arch/arm/boot/dts/armada*
 F:	arch/arm/boot/dts/kirkwood*
+F:	arch/arm64/boot/dts/marvell/armada*
 
 
 ARM/Marvell Berlin SoC support
-- 
2.5.0
