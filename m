From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Thu,  7 Mar 2013 22:58:15 +0100
Subject: [PATCH 09/11] barebox_banner: switch to pr_info
In-Reply-To: <1362693497-2964-1-git-send-email-plagnioj@jcrosoft.com>
References: <20130307215402.GA32347@game.jcrosoft.org>
 <1362693497-2964-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <1362693497-2964-9-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
---
 common/version.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/common/version.c b/common/version.c
index 22e111a..d33f4d0 100644
--- a/common/version.c
+++ b/common/version.c
@@ -16,6 +16,6 @@ void barebox_banner (void)
 	if (!board)
 		board = CONFIG_BOARDINFO;
 
-	printf("\n\n%s\n\n", version_string);
-	printf("Board: %s\n", board);
+	pr_info("\n\n%s\n\n", version_string);
+	pr_info("Board: %s\n", board);
 }
-- 
1.7.10.4
