From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Wed,  3 Oct 2018 16:38:21 +0200
Subject: [PATCH v9 08/11] MAINTAINERS: Update files for PSCI
In-Reply-To: <20181003143824.13059-1-ulf.hansson@linaro.org>
References: <20181003143824.13059-1-ulf.hansson@linaro.org>
Message-ID: <20181003143824.13059-9-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The files for the PSCI firmware driver were moved to a sub-directory,
let's update MAINTAINERS to reflect that.

Suggested-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index b22e7fdfd2ea..710b906037ce 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11624,7 +11624,7 @@ M:	Mark Rutland <mark.rutland@arm.com>
 M:	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
 L:	linux-arm-kernel at lists.infradead.org
 S:	Maintained
-F:	drivers/firmware/psci*.c
+F:	drivers/firmware/psci/
 F:	include/linux/psci.h
 F:	include/uapi/linux/psci.h
 
-- 
2.17.1
