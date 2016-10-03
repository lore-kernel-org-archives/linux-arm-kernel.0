From: eric@anholt.net (Eric Anholt)
Date: Mon,  3 Oct 2016 11:52:09 -0700
Subject: [PATCH 4/4] drivers/vchi: Remove dependency on CONFIG_BROKEN.
In-Reply-To: <20161003185209.27733-1-eric@anholt.net>
References: <20161003185209.27733-1-eric@anholt.net>
Message-ID: <20161003185209.27733-5-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The driver builds now.

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 drivers/staging/vc04_services/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/vc04_services/Kconfig b/drivers/staging/vc04_services/Kconfig
index 9676fb29075a..db8e1beb89f9 100644
--- a/drivers/staging/vc04_services/Kconfig
+++ b/drivers/staging/vc04_services/Kconfig
@@ -1,6 +1,6 @@
 config BCM2708_VCHIQ
 	tristate "Videocore VCHIQ"
-	depends on RASPBERRYPI_FIRMWARE && BROKEN
+	depends on RASPBERRYPI_FIRMWARE
 	default y
 	help
 		Kernel to VideoCore communication interface for the
-- 
2.9.3
