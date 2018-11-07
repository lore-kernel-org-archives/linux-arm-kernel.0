From: peng.hao2@zte.com.cn (Peng Hao)
Date: Wed, 7 Nov 2018 23:39:11 +0800
Subject: [PATCH]  arm64: fix commit style in the comments
Message-ID: <1541605151-6757-1-git-send-email-peng.hao2@zte.com.cn>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use git commit description style 'commit <12+ chars of sha1>
("<title line>")' in the comments.

Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
---
 arch/arm64/kernel/sys32.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/sys32.c b/arch/arm64/kernel/sys32.c
index 0f8bcb7..8317a5a 100644
--- a/arch/arm64/kernel/sys32.c
+++ b/arch/arm64/kernel/sys32.c
@@ -40,8 +40,8 @@
 	 * arbitrary binaries may rely upon it, so we must do the same.
 	 * For more details, see commit:
 	 *
-	 * 713c481519f19df9 ("[ARM] 3108/2: old ABI compat: statfs64 and
-	 * fstatfs64")
+	 * commit 713c481519f19df9 ("[ARM] 3108/2: old ABI compat: statfs64
+	 * and fstatfs64")
 	 */
 	if (sz == 88)
 		sz = 84;
-- 
1.8.3.1
