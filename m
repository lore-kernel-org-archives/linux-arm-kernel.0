From: broonie@kernel.org (Mark Brown)
Date: Fri, 15 Apr 2016 08:53:43 +0100
Subject: [PATCH 3/3] arm64: defconfig: Enable ACPI
In-Reply-To: <1460706823-16566-1-git-send-email-broonie@kernel.org>
References: <1460706823-16566-1-git-send-email-broonie@kernel.org>
Message-ID: <1460706823-16566-3-git-send-email-broonie@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable ACPI by default to support testing of ACPI only systems and
ensure that defconfig will boot on anything, for arm64 this is not done
in Kconfig since a very large proportion of arm64 systems have no ACPI
at all.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index a44ef995d8ae..c5e0132eec57 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -264,6 +264,7 @@ CONFIG_PHY_RCAR_GEN3_USB2=y
 CONFIG_PHY_HI6220_USB=y
 CONFIG_PHY_XGENE=y
 CONFIG_ARM_SCPI_PROTOCOL=y
+CONFIG_ACPI=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT3_FS=y
 CONFIG_FANOTIFY=y
-- 
2.8.0.rc3
