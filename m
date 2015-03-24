From: tsahee@annapurnalabs.com (Tsahee Zidenberg)
Date: Tue, 24 Mar 2015 13:39:45 +0200
Subject: [RFC 1/3] ARM: add generic msi support
Message-ID: <55114d01.Q6m3+16vmo2Ze8u/%tsahee@annapurnalabs.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds arm support for generic msi infrastructure.

Signed-off-by: Tsahee Zidenberg <tsahee@annapurnalabs.com>
---
 arch/arm/include/asm/msi.h | 2 ++
 1 file changed, 2 insertions(+)
 create mode 100644 arch/arm/include/asm/msi.h

diff --git a/arch/arm/include/asm/msi.h b/arch/arm/include/asm/msi.h
new file mode 100644
index 0000000..b6521c9
--- /dev/null
+++ b/arch/arm/include/asm/msi.h
@@ -0,0 +1,2 @@
+#include <asm-generic/msi.h>
+
-- 
1.9.1
