From: zhangwm@marvell.com (Neil Zhang)
Date: Wed, 26 Mar 2014 10:23:21 +0800
Subject: [PATCH] arm64: Fix memory layout typo
Message-ID: <1395800601-17088-1-git-send-email-zhangwm@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Neil Zhang <zhangwm@marvell.com>
---
 Documentation/arm64/memory.txt |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/arm64/memory.txt b/Documentation/arm64/memory.txt
index 5e054bf..c2765e2 100644
--- a/Documentation/arm64/memory.txt
+++ b/Documentation/arm64/memory.txt
@@ -39,7 +39,7 @@ ffffffbffbc00000	ffffffbffbdfffff	   2MB		earlyprintk device
 
 ffffffbffbe00000	ffffffbffbe0ffff	  64KB		PCI I/O space
 
-ffffffbffbe10000	ffffffbcffffffff	  ~2MB		[guard]
+ffffffbffbe10000	ffffffbffbffffff	  ~2MB		[guard]
 
 ffffffbffc000000	ffffffbfffffffff	  64MB		modules
 
-- 
1.7.9.5
