From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 29 Jul 2014 14:34:45 +0100
Subject: [PATCH 1/1] MAINTAINERS: Update MFD repo location
Message-ID: <1406640885-20481-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The old one hasn't been used for well over 6 months.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 61a8f48..676372b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6002,8 +6002,7 @@ F:	include/media/mt9v032.h
 MULTIFUNCTION DEVICES (MFD)
 M:	Samuel Ortiz <sameo@linux.intel.com>
 M:	Lee Jones <lee.jones@linaro.org>
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/sameo/mfd-next.git
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/sameo/mfd-fixes.git
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git
 S:	Supported
 F:	drivers/mfd/
 F:	include/linux/mfd/
-- 
1.9.1
