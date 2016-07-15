From: anup.patel@broadcom.com (Anup Patel)
Date: Fri, 15 Jul 2016 14:33:56 +0530
Subject: [PATCH 1/8] uio: code style cleanup
In-Reply-To: <1468573443-4670-1-git-send-email-anup.patel@broadcom.com>
References: <1468573443-4670-1-git-send-email-anup.patel@broadcom.com>
Message-ID: <1468573443-4670-2-git-send-email-anup.patel@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ankit Jindal <thatsjindal@gmail.com>

This patch fixes the indentation of switch-case block in uio driver.

Signed-off-by: Ankit Jindal <thatsjindal@gmail.com>
Signed-off-by: Anup Patel <anup.patel@broadcom.com>
---
 drivers/uio/uio.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/uio/uio.c b/drivers/uio/uio.c
index fba021f..f2729b7 100644
--- a/drivers/uio/uio.c
+++ b/drivers/uio/uio.c
@@ -703,13 +703,13 @@ static int uio_mmap(struct file *filep, struct vm_area_struct *vma)
 	}
 
 	switch (idev->info->mem[mi].memtype) {
-		case UIO_MEM_PHYS:
-			return uio_mmap_physical(vma);
-		case UIO_MEM_LOGICAL:
-		case UIO_MEM_VIRTUAL:
-			return uio_mmap_logical(vma);
-		default:
-			return -EINVAL;
+	case UIO_MEM_PHYS:
+		return uio_mmap_physical(vma);
+	case UIO_MEM_LOGICAL:
+	case UIO_MEM_VIRTUAL:
+		return uio_mmap_logical(vma);
+	default:
+		return -EINVAL;
 	}
 }
 
-- 
1.9.1
