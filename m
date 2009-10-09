From: alan-jenkins@tuffmail.co.uk (Alan Jenkins)
Date: Fri,  9 Oct 2009 15:02:18 +0100
Subject: [PATCH 2/6] ARM: remove out of date comment
In-Reply-To: <1255096942-10451-1-git-send-email-alan-jenkins@tuffmail.co.uk>
References: <1255096942-10451-1-git-send-email-alan-jenkins@tuffmail.co.uk>
Message-ID: <1255096942-10451-2-git-send-email-alan-jenkins@tuffmail.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All exports are now versioned.  See historical commit
"Convert in-kernel users of EXPORT_SYMBOL_NOVERS() to  EXPORT_SYMBOL()"

Signed-off-by: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
---
 arch/arm/kernel/armksyms.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/kernel/armksyms.c b/arch/arm/kernel/armksyms.c
index 724fc10..255b7b8 100644
--- a/arch/arm/kernel/armksyms.c
+++ b/arch/arm/kernel/armksyms.c
@@ -24,7 +24,7 @@
 /*
  * libgcc functions - functions that are used internally by the
  * compiler...  (prototypes are not correct though, but that
- * doesn't really matter since they're not versioned).
+ * doesn't really matter).
  */
 extern void __ashldi3(void);
 extern void __ashrdi3(void);
-- 
1.6.3.2
