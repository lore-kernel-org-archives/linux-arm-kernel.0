From: dave.bueso@gmail.com (Davidlohr Bueso)
Date: Sat, 03 Jul 2010 06:21:04 -0400
Subject: [PATCH padmux.c] Fix typo in kerneldoc
Message-ID: <1278152464.27251.3.camel@cowboy>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Trivial fix in a typo (enalbed for enabled).

Thanks,
Davidlohr


Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
 arch/arm/plat-spear/padmux.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-spear/padmux.c b/arch/arm/plat-spear/padmux.c
index d2aab3a..555eec6 100644
--- a/arch/arm/plat-spear/padmux.c
+++ b/arch/arm/plat-spear/padmux.c
@@ -66,7 +66,7 @@ static int pmx_mode_set(struct pmx_mode *mode)
  * If peripheral is not supported by current mode then request is rejected.
  * Conflicts between peripherals are not handled and peripherals will be
  * enabled in the order they are present in pmx_dev array.
- * In case of conflicts last peripheral enalbed will be present.
+ * In case of conflicts last peripheral enabled will be present.
  * Returns -ve on Err otherwise 0
  */
 static int pmx_devs_enable(struct pmx_dev **devs, u8 count)
-- 
1.7.0.4
