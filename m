From: fthain@telegraphics.com.au (Finn Thain)
Date: Tue,  4 Oct 2016 01:40:50 -0400 (EDT)
Subject: [PATCH 02/12] scsi/cumana_1: Remove unused cumanascsi_setup() function
In-Reply-To: <cover.1475559357.git.fthain@telegraphics.com.au>
References: <cover.1475559357.git.fthain@telegraphics.com.au>
Message-ID: <27baf9a385d0f85f539e81be46e1a4ef8c67226c.1475559357.git.fthain@telegraphics.com.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 drivers/scsi/arm/cumana_1.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/scsi/arm/cumana_1.c b/drivers/scsi/arm/cumana_1.c
index 8e9cfe8..f616756 100644
--- a/drivers/scsi/arm/cumana_1.c
+++ b/drivers/scsi/arm/cumana_1.c
@@ -33,10 +33,6 @@
 
 #include "../NCR5380.h"
 
-void cumanascsi_setup(char *str, int *ints)
-{
-}
-
 #define CTRL	0x16fc
 #define STAT	0x2004
 #define L(v)	(((v)<<16)|((v) & 0x0000ffff))
-- 
2.7.3
