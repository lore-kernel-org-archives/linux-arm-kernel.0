From: shiju.jose@huawei.com (Shiju Jose)
Date: Tue, 20 Mar 2018 12:23:24 +0000
Subject: [PATCH]arm64:defconfig:enable ACPI_APEI_SEA
Message-ID: <aa732187-e12a-68e5-d15e-84090855d2c5@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable ACPI APEI SEA option for arm64, to handle
ARMv8 SEA(Synchronous External Abort).

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
Cc: Tyler Baicar <tbaicar@codeaurora.org>
Cc: James Morse <james.morse@arm.com>
Cc: Dongjiu Geng <gengdongjiu@huawei.com>
Cc: Xie XiuQi <xiexiuqi@huawei.com>
Cc: Qiang Zheng <zhengqiang10@huawei.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 634b373..5ddf25c 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -574,6 +574,7 @@ CONFIG_ACPI_APEI_GHES=y
 CONFIG_ACPI_APEI_PCIEAER=y
 CONFIG_ACPI_APEI_MEMORY_FAILURE=y
 CONFIG_ACPI_APEI_EINJ=y
+CONFIG_ACPI_APEI_SEA=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT3_FS=y
 CONFIG_EXT4_FS_POSIX_ACL=y
-- 
1.9.1
