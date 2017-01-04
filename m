From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Wed,  4 Jan 2017 13:35:32 +0000
Subject: [PATCH 4/5] ARM: qcom_defconfig: add ahci configs
In-Reply-To: <1483536933-21503-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1483536933-21503-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1483536933-21503-5-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables configs required to get SATA functionality working on
IFC6410 board.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm/configs/qcom_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/qcom_defconfig b/arch/arm/configs/qcom_defconfig
index 255b9f6..f3d1114 100644
--- a/arch/arm/configs/qcom_defconfig
+++ b/arch/arm/configs/qcom_defconfig
@@ -71,6 +71,9 @@ CONFIG_CHR_DEV_SCH=y
 CONFIG_SCSI_CONSTANTS=y
 CONFIG_SCSI_LOGGING=y
 CONFIG_SCSI_SCAN_ASYNC=y
+CONFIG_ATA=y
+CONFIG_SATA_AHCI=y
+CONFIG_SATA_AHCI_PLATFORM=y
 CONFIG_NETDEVICES=y
 CONFIG_DUMMY=y
 CONFIG_ATL1C=y
-- 
2.10.1
