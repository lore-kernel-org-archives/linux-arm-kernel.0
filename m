From: rickard_strandqvist@spectrumdigital.se (Rickard Strandqvist)
Date: Sat, 20 Dec 2014 17:36:15 +0100
Subject: [PATCH] scsi: arm: cumana_1.c:  Remove unused function
Message-ID: <1419093375-8016-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove the function cumanascsi_setup() that is not used anywhere.

This was partially found by using a static code analysis program called cppcheck.

Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
---
 drivers/scsi/arm/cumana_1.c |    4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/scsi/arm/cumana_1.c b/drivers/scsi/arm/cumana_1.c
index 8ef810a..7c90d9c 100644
--- a/drivers/scsi/arm/cumana_1.c
+++ b/drivers/scsi/arm/cumana_1.c
@@ -38,10 +38,6 @@
 
 #include "../NCR5380.h"
 
-void cumanascsi_setup(char *str, int *ints)
-{
-}
-
 const char *cumanascsi_info(struct Scsi_Host *spnt)
 {
 	return "";
-- 
1.7.10.4
