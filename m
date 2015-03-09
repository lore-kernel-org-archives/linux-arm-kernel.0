From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Mon,  9 Mar 2015 10:27:10 +0000
Subject: [PATCH 6/6] Documentation: update arch list in the 'memtest' entry
In-Reply-To: <1425896830-19705-1-git-send-email-vladimir.murzin@arm.com>
References: <1425896830-19705-1-git-send-email-vladimir.murzin@arm.com>
Message-ID: <1425896830-19705-7-git-send-email-vladimir.murzin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since arm64/arm support memtest command line option update the "memtest"
entry.

Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
---
 Documentation/kernel-parameters.txt |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index bfcb1a6..ea11c98 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -1988,7 +1988,7 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
 			seconds.  Use this parameter to check at some
 			other rate.  0 disables periodic checking.
 
-	memtest=	[KNL,X86] Enable memtest
+	memtest=	[KNL,X86,ARM] Enable memtest
 			Format: <integer>
 			default : 0 <disable>
 			Specifies the number of memtest passes to be
-- 
1.7.9.5
