From: felipe.contreras@gmail.com (Felipe Contreras)
Date: Sun, 10 Oct 2010 20:40:40 +0300
Subject: [PATCH 3/3] staging: tidspbridge: remove memory consistency from TODO
	list
In-Reply-To: <1286732440-28644-1-git-send-email-felipe.contreras@gmail.com>
References: <1286732440-28644-1-git-send-email-felipe.contreras@gmail.com>
Message-ID: <1286732440-28644-4-git-send-email-felipe.contreras@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mempool area is not handled by the kernel any more.

Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 drivers/staging/tidspbridge/TODO |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/tidspbridge/TODO b/drivers/staging/tidspbridge/TODO
index 187363f..54f4a29 100644
--- a/drivers/staging/tidspbridge/TODO
+++ b/drivers/staging/tidspbridge/TODO
@@ -13,7 +13,6 @@
 * Audit and clean up header files folder
 * Use kernel coding style
 * checkpatch.pl fixes
-* allocate ext_mem_pool from consistent memory instead of using ioremap
 
 Please send any patches to Greg Kroah-Hartman <greg@kroah.com>
 and Omar Ramirez Luna <omar.ramirez@ti.com>.
-- 
1.7.3.1.2.g7fe2b
