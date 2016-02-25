From: georgi.djakov@linaro.org (Georgi Djakov)
Date: Thu, 25 Feb 2016 12:46:32 +0200
Subject: [PATCH v3 2/2] arm64: defconfig: Increase MMC_BLOCK_MINORS to 16
In-Reply-To: <1456397192-2407-1-git-send-email-georgi.djakov@linaro.org>
References: <1456397192-2407-1-git-send-email-georgi.djakov@linaro.org>
Message-ID: <1456397192-2407-2-git-send-email-georgi.djakov@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Increase the block minors from the default 8 to 16. The db410c board
by default has eMMC rootfs on the 10th partition.

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 arch/arm64/configs/defconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 47b5dac96bfc..7787e4031a75 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -192,6 +192,7 @@ CONFIG_USB_MSM_OTG=y
 CONFIG_USB_ULPI=y
 CONFIG_USB_GADGET=y
 CONFIG_MMC=y
+CONFIG_MMC_BLOCK_MINORS=16
 CONFIG_MMC_ARMMMCI=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_PLTFM=y
