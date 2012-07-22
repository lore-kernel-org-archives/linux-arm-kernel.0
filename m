From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Sun, 22 Jul 2012 15:18:57 +0200
Subject: [PATCH 2/7] decompress_unlzo: define decompress_unlzo as decompress
In-Reply-To: <1342963142-30339-1-git-send-email-plagnioj@jcrosoft.com>
References: <20120722130301.GI22657@game.jcrosoft.org>
 <1342963142-30339-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <1342963142-30339-2-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

so we can use decompress in the decompressor
this will simplify multi decompress support

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
---
 lib/decompress_unlzo.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/decompress_unlzo.c b/lib/decompress_unlzo.c
index 0e6a7ad..56abfc6 100644
--- a/lib/decompress_unlzo.c
+++ b/lib/decompress_unlzo.c
@@ -289,3 +289,4 @@ exit_1:
 exit:
 	return ret;
 }
+#define decompress decompress_unlzo
-- 
1.7.10
