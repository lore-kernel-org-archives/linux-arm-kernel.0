From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Wed, 14 Mar 2018 17:58:33 +0100
Subject: [PATCH v6 23/25] MAINTAINERS: Update files for PSCI
In-Reply-To: <1521046715-30683-1-git-send-email-ulf.hansson@linaro.org>
References: <1521046715-30683-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <1521046715-30683-24-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some new files have been for the PSCI firmware driver, let's make the
expression more generic to cover them all.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4623caf..dda16cf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11082,7 +11082,7 @@ M:	Mark Rutland <mark.rutland@arm.com>
 M:	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
 L:	linux-arm-kernel at lists.infradead.org
 S:	Maintained
-F:	drivers/firmware/psci*.c
+F:	drivers/firmware/psci*
 F:	include/linux/psci.h
 F:	include/uapi/linux/psci.h
 
-- 
2.7.4
