From: gakula@caviumnetworks.com (Geetha sowjanya)
Date: Wed, 10 May 2017 17:01:55 +0530
Subject: [v5 1/4] ACPICA: IORT: Add Cavium ThunderX2 SMMUv3 model definition.
In-Reply-To: <1494415918-13770-1-git-send-email-gakula@caviumnetworks.com>
References: <1494415918-13770-1-git-send-email-gakula@caviumnetworks.com>
Message-ID: <1494415918-13770-2-git-send-email-gakula@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linu Cherian <linu.cherian@cavium.com>

Add SMMUv3 model definition for ThunderX2.

Signed-off-by: Linu Cherian <linu.cherian@cavium.com>
Signed-off-by: Geetha Sowjanya <geethasowjanya.akula@cavium.com>
---
 include/acpi/actbl2.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index faa9f2c..76a6f5d 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -779,6 +779,8 @@ struct acpi_iort_smmu {
 #define ACPI_IORT_SMMU_CORELINK_MMU400  0x00000002	/* ARM Corelink MMU-400 */
 #define ACPI_IORT_SMMU_CORELINK_MMU500  0x00000003	/* ARM Corelink MMU-500 */
 
+#define ACPI_IORT_SMMU_V3_CAVIUM_CN99XX 0x00000002 /* Cavium ThunderX2 SMMUv3 */
+
 /* Masks for Flags field above */
 
 #define ACPI_IORT_SMMU_DVM_SUPPORTED    (1)
-- 
1.8.3.1
