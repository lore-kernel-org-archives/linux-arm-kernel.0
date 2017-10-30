From: wenyou.yang@microchip.com (Wenyou Yang)
Date: Mon, 30 Oct 2017 09:44:32 +0800
Subject: [PATCH v3 3/3] MAINTAINERS: Add a new entry of the ov7740 driver
In-Reply-To: <20171030014432.24025-1-wenyou.yang@microchip.com>
References: <20171030014432.24025-1-wenyou.yang@microchip.com>
Message-ID: <20171030014432.24025-4-wenyou.yang@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a new entry of the ov7740 sensor driver to the MAINTAINERS file.

Signed-off-by: Wenyou Yang <wenyou.yang@microchip.com>
---

Changes in v3:
 - Put the MAINTAINERS change to a separate patch.

Changes in v2:
 - Split off the bindings into a separate patch.
 - Add a new entry to the MAINTAINERS file.

 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index adbf69306e9e..42b93599a0af 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9973,6 +9973,14 @@ S:	Maintained
 F:	drivers/media/i2c/ov7670.c
 F:	Documentation/devicetree/bindings/media/i2c/ov7670.txt
 
+OMNIVISION OV7740 SENSOR DRIVER
+M:	Wenyou Yang <wenyou.yang@microchip.com>
+L:	linux-media at vger.kernel.org
+T:	git git://linuxtv.org/media_tree.git
+S:	Maintained
+F:	drivers/media/i2c/ov7740.c
+F:	Documentation/devicetree/bindings/media/i2c/ov7740.txt
+
 ONENAND FLASH DRIVER
 M:	Kyungmin Park <kyungmin.park@samsung.com>
 L:	linux-mtd at lists.infradead.org
-- 
2.13.0
