From: sumit.semwal@ti.com (Sumit Semwal)
Date: Mon, 26 Dec 2011 14:53:17 +0530
Subject: [PATCH 3/3] dma-buf: mark EXPERIMENTAL for 1st release.
In-Reply-To: <1324891397-10877-1-git-send-email-sumit.semwal@ti.com>
References: <1324891397-10877-1-git-send-email-sumit.semwal@ti.com>
Message-ID: <1324891397-10877-4-git-send-email-sumit.semwal@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark dma-buf buffer sharing API as EXPERIMENTAL for first release.
We will remove this in later versions, once it gets smoothed out
and has more users.

Signed-off-by: Sumit Semwal <sumit.semwal@linaro.org>
Signed-off-by: Sumit Semwal <sumit.semwal@ti.com>
---
 drivers/base/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
index 8a0e87f..e95c67e 100644
--- a/drivers/base/Kconfig
+++ b/drivers/base/Kconfig
@@ -178,6 +178,7 @@ config DMA_SHARED_BUFFER
 	bool "Buffer framework to be shared between drivers"
 	default n
 	select ANON_INODES
+	depends on EXPERIMENTAL
 	help
 	  This option enables the framework for buffer-sharing between
 	  multiple drivers. A buffer is associated with a file using driver
-- 
1.7.5.4
