From: andrea.gelmini@gelma.net (Andrea Gelmini)
Date: Sat, 21 May 2016 13:47:27 +0200
Subject: [PATCH 0081/1529] Fix typo
Message-ID: <20160521114727.3496-1-andrea.gelmini@gelma.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 arch/arm/common/scoop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/common/scoop.c b/arch/arm/common/scoop.c
index 9ba45ad..5e24e06 100644
--- a/arch/arm/common/scoop.c
+++ b/arch/arm/common/scoop.c
@@ -27,7 +27,7 @@
    is used which is setup by the platform code.
 
    This file is never modular so this symbol is always
-   accessile to the board support files.
+   accessible to the board support files.
 */
 struct scoop_pcmcia_config *platform_scoop_config;
 EXPORT_SYMBOL(platform_scoop_config);
-- 
2.8.2.534.g1f66975
