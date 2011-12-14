From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Wed, 14 Dec 2011 13:48:34 +0200
Subject: [PATCH 6/7] remoteproc: add Kconfig menu
In-Reply-To: <1323863315-8159-1-git-send-email-ohad@wizery.com>
References: <1323863315-8159-1-git-send-email-ohad@wizery.com>
Message-ID: <1323863315-8159-7-git-send-email-ohad@wizery.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a dedicated Kconfig menu for the remoteproc drivers, so they
don't show up in the main driver menu.

Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
---
 drivers/remoteproc/Kconfig |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
index 396c97a..00fb72f 100644
--- a/drivers/remoteproc/Kconfig
+++ b/drivers/remoteproc/Kconfig
@@ -1,3 +1,5 @@
+menu "Remoteproc drivers"
+
 # REMOTEPROC gets selected by whoever wants it
 config REMOTEPROC
 	tristate
@@ -22,3 +24,5 @@ config OMAP_REMOTEPROC
 
 	  It's safe to say n here if you're not interested in multimedia
 	  offloading or just want a bare minimum kernel.
+
+endmenu
-- 
1.7.5.4
