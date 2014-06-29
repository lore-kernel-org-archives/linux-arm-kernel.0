From: a.heider@gmail.com (Andre Heider)
Date: Sun, 29 Jun 2014 18:21:45 +0200
Subject: [PATCH 11/13] uio: uio_pruss: enable the driver for am33xx SoCs
In-Reply-To: <1404058907-21112-1-git-send-email-a.heider@gmail.com>
References: <1404058907-21112-1-git-send-email-a.heider@gmail.com>
Message-ID: <1404058907-21112-12-git-send-email-a.heider@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Andre Heider <a.heider@gmail.com>
---
 drivers/uio/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/uio/Kconfig b/drivers/uio/Kconfig
index 5a90914..1678387 100644
--- a/drivers/uio/Kconfig
+++ b/drivers/uio/Kconfig
@@ -106,10 +106,10 @@ config UIO_NETX
 
 config UIO_PRUSS
 	tristate "Texas Instruments PRUSS driver"
-	depends on ARCH_DAVINCI_DA850
+	depends on ARCH_DAVINCI_DA850 || SOC_AM33XX
 	select GENERIC_ALLOCATOR
 	help
-	  PRUSS driver for OMAPL138/DA850/AM18XX devices
+	  PRUSS driver for OMAPL138/DA850/AM18XX/AM33XX devices
 	  PRUSS driver requires user space components, examples and user space
 	  driver is available from below SVN repo - you may use anonymous login
 
-- 
2.0.0
