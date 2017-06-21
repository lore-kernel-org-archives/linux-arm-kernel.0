From: timur@codeaurora.org (Timur Tabi)
Date: Wed, 21 Jun 2017 12:30:42 -0500
Subject: [PATCH 3/8] arm64: defconfig: enable EFI_CAPSULE_LOADER
In-Reply-To: <1498066247-22130-1-git-send-email-timur@codeaurora.org>
References: <1498066247-22130-1-git-send-email-timur@codeaurora.org>
Message-ID: <1498066247-22130-4-git-send-email-timur@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CONFIG_EFI_CAPSULE_LOADER allows the user to update the EFI firmware,
which is useful on ARM64 server platforms.

Signed-off-by: Timur Tabi <timur@codeaurora.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index c1add12..066c166 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -500,6 +500,7 @@ CONFIG_PHY_XGENE=y
 CONFIG_PHY_TEGRA_XUSB=y
 CONFIG_ARM_SCPI_PROTOCOL=y
 CONFIG_RASPBERRYPI_FIRMWARE=y
+CONFIG_EFI_CAPSULE_LOADER=y
 CONFIG_ACPI=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT3_FS=y
-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
