From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue,  3 Jan 2017 12:32:48 +0000
Subject: [PATCH 2/2] MAINTAINERS: extend PSCI entry to cover the newly add
 PSCI checker code
In-Reply-To: <1483446768-26973-1-git-send-email-sudeep.holla@arm.com>
References: <1483446768-26973-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <1483446768-26973-2-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch extends the file entry for PSCI so that the newly added
PSCI checker module code is also covered.

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index cfff2c9e3d94..c7397bdef186 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9842,7 +9842,7 @@ M:	Mark Rutland <mark.rutland@arm.com>
 M:	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
 L:	linux-arm-kernel at lists.infradead.org
 S:	Maintained
-F:	drivers/firmware/psci.c
+F:	drivers/firmware/psci*.c
 F:	include/linux/psci.h
 F:	include/uapi/linux/psci.h
 
-- 
2.7.4
