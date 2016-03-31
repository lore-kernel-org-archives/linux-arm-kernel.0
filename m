From: aleksey.makarov@linaro.org (Aleksey Makarov)
Date: Thu, 31 Mar 2016 16:40:24 +0300
Subject: [PATCH v7 2/5] ACPICA: Headers: Add new constants for the DBG2 ACPI
 table
In-Reply-To: <1459431629-27934-1-git-send-email-aleksey.makarov@linaro.org>
References: <1459431629-27934-1-git-send-email-aleksey.makarov@linaro.org>
Message-ID: <1459431629-27934-3-git-send-email-aleksey.makarov@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ACPICA commit 1607b69238df9c1b2940262a17aa94ec49033278

Link: https://github.com/acpica/acpica/commit/1607b692
Signed-off-by: Aleksey Makarov <aleksey.makarov@linaro.org>.
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---

DO NOT MERGE

This patch is from pending ACPICA series [1].  It is needed by the next patch,
but has not been merged to linux-next yet.

[1] https://lkml.kernel.org/g/cover.1458714002.git.lv.zheng at intel.com

 include/acpi/actbl2.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index a4ef625..7702b27 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -321,7 +321,7 @@ struct acpi_csrt_descriptor {
  * DBG2 - Debug Port Table 2
  *        Version 0 (Both main table and subtables)
  *
- * Conforms to "Microsoft Debug Port Table 2 (DBG2)", May 22 2012.
+ * Conforms to "Microsoft Debug Port Table 2 (DBG2)", December 10, 2015
  *
  ******************************************************************************/
 
@@ -371,6 +371,11 @@ struct acpi_dbg2_device {
 
 #define ACPI_DBG2_16550_COMPATIBLE  0x0000
 #define ACPI_DBG2_16550_SUBSET      0x0001
+#define ACPI_DBG2_ARM_PL011         0x0003
+#define ACPI_DBG2_ARM_SBSA_32BIT    0x000D
+#define ACPI_DBG2_ARM_SBSA_GENERIC  0x000E
+#define ACPI_DBG2_ARM_DCC           0x000F
+#define ACPI_DBG2_BCM2835           0x0010
 
 #define ACPI_DBG2_1394_STANDARD     0x0000
 
-- 
2.7.4
