From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Tue, 24 Dec 2013 15:32:11 +0200
Subject: [PATCH v2 6/6] misc: enable fuse drivers
In-Reply-To: <1387891931-9854-1-git-send-email-pdeschrijver@nvidia.com>
References: <1387891931-9854-1-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <1387891931-9854-7-git-send-email-pdeschrijver@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable building the fuse drivers.

Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
---
 drivers/misc/Kconfig  |    1 +
 drivers/misc/Makefile |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 6cb388e..45560dc 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -526,4 +526,5 @@ source "drivers/misc/mei/Kconfig"
 source "drivers/misc/vmw_vmci/Kconfig"
 source "drivers/misc/mic/Kconfig"
 source "drivers/misc/genwqe/Kconfig"
+source "drivers/misc/fuse/Kconfig"
 endmenu
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index 99b9424..e243a8b 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -54,3 +54,4 @@ obj-$(CONFIG_LATTICE_ECP3_CONFIG)	+= lattice-ecp3-config.o
 obj-$(CONFIG_SRAM)		+= sram.o
 obj-y				+= mic/
 obj-$(CONFIG_GENWQE)		+= genwqe/
+obj-y				+= fuse/
-- 
1.7.7.rc0.72.g4b5ea.dirty
