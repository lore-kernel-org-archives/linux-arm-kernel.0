From: mturquette@linaro.org (Mike Turquette)
Date: Sun, 6 May 2012 22:08:26 -0700
Subject: [PATCH 1/5] MAINTAINERS: add entry for common clk framework
In-Reply-To: <1336367310-5140-1-git-send-email-mturquette@linaro.org>
References: <1336367310-5140-1-git-send-email-mturquette@linaro.org>
Message-ID: <1336367310-5140-2-git-send-email-mturquette@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Mike Turquette <mturquette@linaro.org>
---
 MAINTAINERS |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1a2f8f5..164e9a1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1882,6 +1882,16 @@ F:	Documentation/filesystems/coda.txt
 F:	fs/coda/
 F:	include/linux/coda*.h
 
+COMMON CLK FRAMEWORK
+M:	Mike Turquette <mturquette@ti.com>
+M:	Mike Turquette <mturquette@linaro.org>
+L:	linux-arm-kernel at lists.infradead.org (same as CLK API & CLKDEV)
+T:	git git://git.linaro.org/people/mturquette/linux.git
+S:	Maintained
+F:	drivers/clk/clk.c
+F:	drivers/clk/clk-*
+F:	include/linux/clk-pr*
+
 COMMON INTERNET FILE SYSTEM (CIFS)
 M:	Steve French <sfrench@samba.org>
 L:	linux-cifs at vger.kernel.org
-- 
1.7.5.4
