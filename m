From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Wed,  4 Jan 2017 13:35:31 +0000
Subject: [PATCH 3/5] ARM: qcom_defconfig: add pcie and atl1c ethernet configs
In-Reply-To: <1483536933-21503-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1483536933-21503-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1483536933-21503-4-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

IFC6410 board has PCIE based ATL1C ethernet controller, so enable related configs.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm/configs/qcom_defconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/configs/qcom_defconfig b/arch/arm/configs/qcom_defconfig
index 9b2a1f0..255b9f6 100644
--- a/arch/arm/configs/qcom_defconfig
+++ b/arch/arm/configs/qcom_defconfig
@@ -24,6 +24,9 @@ CONFIG_ARCH_MSM8X60=y
 CONFIG_ARCH_MSM8960=y
 CONFIG_ARCH_MSM8974=y
 CONFIG_ARCH_MDM9615=y
+CONFIG_PCI=y
+CONFIG_PCI_MSI=y
+CONFIG_PCIE_QCOM=y
 CONFIG_SMP=y
 CONFIG_HAVE_ARM_ARCH_TIMER=y
 CONFIG_PREEMPT=y
@@ -70,6 +73,7 @@ CONFIG_SCSI_LOGGING=y
 CONFIG_SCSI_SCAN_ASYNC=y
 CONFIG_NETDEVICES=y
 CONFIG_DUMMY=y
+CONFIG_ATL1C=y
 CONFIG_KS8851=y
 CONFIG_MDIO_BITBANG=y
 CONFIG_MDIO_GPIO=y
-- 
2.10.1
