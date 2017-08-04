From: shiju.jose@huawei.com (Shiju Jose)
Date: Fri, 4 Aug 2017 12:23:43 +0100
Subject: [RFC PATCH v4.13-rc3] arm64: defconfig: enable
 CONFIG_ACPI_APEI_MEMORY_FAILURE
Message-ID: <cff81f88-8040-f2ca-35b8-6047378aa504@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable ACPI APEI MEMORY FAILURE option for ARM64,
so that memory errors can be handled.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 50429c0..6748583 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -521,7 +521,9 @@ CONFIG_EFI_CAPSULE_LOADER=y
 CONFIG_ACPI=y
 CONFIG_ACPI_APEI=y
 CONFIG_ACPI_APEI_GHES=y
+CONFIG_ACPI_APEI_MEMORY_FAILURE=y
 CONFIG_ACPI_APEI_PCIEAER=y
+CONFIG_MEMORY_FAILURE=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT3_FS=y
 CONFIG_EXT4_FS_POSIX_ACL=y
-- 
1.9.1
