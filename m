From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Mon,  9 Mar 2015 10:27:09 +0000
Subject: [PATCH 5/6] Kconfig: memtest: update number of test patterns up to 17
In-Reply-To: <1425896830-19705-1-git-send-email-vladimir.murzin@arm.com>
References: <1425896830-19705-1-git-send-email-vladimir.murzin@arm.com>
Message-ID: <1425896830-19705-6-git-send-email-vladimir.murzin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Additional test patterns for memtest were introduced since 63823126
"x86: memtest: add additional (regular) test patterns", but looks like
Kconfig was not updated that time.

Update Kconfig entry with the actual number of maximum test patterns.

Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
---
 lib/Kconfig.debug |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 8eb064fd..2832b0e 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1740,7 +1740,7 @@ config MEMTEST
 	        memtest=0, mean disabled; -- default
 	        memtest=1, mean do 1 test pattern;
 	        ...
-	        memtest=4, mean do 4 test patterns.
+	        memtest=17, mean do 17 test patterns.
 	  If you are unsure how to answer this question, answer N.
 
 source "samples/Kconfig"
-- 
1.7.9.5
