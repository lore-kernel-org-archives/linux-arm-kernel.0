From: mst@redhat.com (Michael S. Tsirkin)
Date: Tue, 6 Jan 2015 17:45:15 +0200
Subject: [PATCH v2 31/40] arm64: macro whitespace fixes
In-Reply-To: <1420558883-10131-1-git-send-email-mst@redhat.com>
References: <1420558883-10131-1-git-send-email-mst@redhat.com>
Message-ID: <1420558883-10131-32-git-send-email-mst@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

While working on arch/arm64/include/asm/uaccess.h, I noticed
that one macro within this header is made harder to read because it
violates a coding style rule: space is missing after comma.

Fix it up.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 arch/arm64/include/asm/uaccess.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
index 9a2069b..07e1ba44 100644
--- a/arch/arm64/include/asm/uaccess.h
+++ b/arch/arm64/include/asm/uaccess.h
@@ -63,7 +63,7 @@ static inline void set_fs(mm_segment_t fs)
 	current_thread_info()->addr_limit = fs;
 }
 
-#define segment_eq(a,b)	((a) == (b))
+#define segment_eq(a, b)	((a) == (b))
 
 /*
  * Return 1 if addr < current->addr_limit, 0 otherwise.
-- 
MST
