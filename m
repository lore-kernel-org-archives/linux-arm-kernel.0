From: songjun.wu@microchip.com (Songjun Wu)
Date: Wed, 17 Aug 2016 14:05:29 +0800
Subject: [PATCH v10 3/3] MAINTAINERS: atmel-isc: add entry for Atmel ISC
In-Reply-To: <1471413929-26008-1-git-send-email-songjun.wu@microchip.com>
References: <1471413929-26008-1-git-send-email-songjun.wu@microchip.com>
Message-ID: <1471413929-26008-4-git-send-email-songjun.wu@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the MAINTAINERS' entry for Microchip / Atmel Image Sensor Controller.

Signed-off-by: Songjun Wu <songjun.wu@microchip.com>
---

Changes in v10: None
Changes in v9: None
Changes in v8: None
Changes in v7: None
Changes in v6: None
Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None

 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 20bb1d0..21a6f6f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7733,6 +7733,14 @@ T:	git git://git.monstr.eu/linux-2.6-microblaze.git
 S:	Supported
 F:	arch/microblaze/
 
+MICROCHIP / ATMEL ISC DRIVER
+M:	Songjun Wu <songjun.wu@microchip.com>
+L:	linux-media at vger.kernel.org
+S:	Supported
+F:	drivers/media/platform/atmel/atmel-isc.c
+F:	drivers/media/platform/atmel/atmel-isc-regs.h
+F:	devicetree/bindings/media/atmel-isc.txt
+
 MICROSOFT SURFACE PRO 3 BUTTON DRIVER
 M:	Chen Yu <yu.c.chen@intel.com>
 L:	platform-driver-x86 at vger.kernel.org
-- 
2.7.4
