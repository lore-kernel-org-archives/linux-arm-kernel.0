From: yang.shi@linaro.org (Yang Shi)
Date: Fri, 18 Sep 2015 14:09:00 -0700
Subject: [PATCH] arm64: debug: Fix typo in debug-monitors.c
Message-ID: <1442610540-8393-1-git-send-email-yang.shi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix handers to handlers.

Signed-off-by: Yang Shi <yang.shi@linaro.org>
---
 arch/arm64/kernel/debug-monitors.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/debug-monitors.c b/arch/arm64/kernel/debug-monitors.c
index cebf786..8eef30f 100644
--- a/arch/arm64/kernel/debug-monitors.c
+++ b/arch/arm64/kernel/debug-monitors.c
@@ -201,7 +201,7 @@ void unregister_step_hook(struct step_hook *hook)
 }
 
 /*
- * Call registered single step handers
+ * Call registered single step handlers
  * There is no Syndrome info to check for determining the handler.
  * So we call all the registered handlers, until the right handler is
  * found which returns zero.
-- 
2.0.2
