From: contact@paulk.fr (Paul Kocialkowski)
Date: Sun, 28 Feb 2016 13:39:44 +0100
Subject: [PATCH v4 4/5] ARM: omap2plus_defconfig: Enable LP872x regulator
 support
In-Reply-To: <1456663185-14170-1-git-send-email-contact@paulk.fr>
References: <1456663185-14170-1-git-send-email-contact@paulk.fr>
Message-ID: <1456663185-14170-5-git-send-email-contact@paulk.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The LP872x regulator is used in the LG Optimus Black codename sniper to supply
the external mmc card.

Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
---
 arch/arm/configs/omap2plus_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index d18d6b4..0c5f728 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -278,6 +278,7 @@ CONFIG_MFD_TPS65218=y
 CONFIG_MFD_TPS65910=y
 CONFIG_MFD_TI_AM335X_TSCADC=m
 CONFIG_TWL6040_CORE=y
+CONFIG_REGULATOR_LP872X=y
 CONFIG_REGULATOR_PALMAS=y
 CONFIG_REGULATOR_PBIAS=y
 CONFIG_REGULATOR_TI_ABB=y
-- 
2.6.4
