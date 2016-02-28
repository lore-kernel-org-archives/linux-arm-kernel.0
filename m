From: contact@paulk.fr (Paul Kocialkowski)
Date: Sun, 28 Feb 2016 11:20:27 +0100
Subject: [PATCH v3 4/4] ARM: multi_v7_defconfig: Enable LP872x regulator
 support
In-Reply-To: <1456654827-11349-1-git-send-email-contact@paulk.fr>
References: <1456654827-11349-1-git-send-email-contact@paulk.fr>
Message-ID: <1456654827-11349-5-git-send-email-contact@paulk.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The LP872x regulator is used in the LG Optimus Black codename sniper to supply
the external mmc card.

Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 8e8b2ac..59d65bd 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -468,6 +468,7 @@ CONFIG_REGULATOR_RK808=y
 CONFIG_REGULATOR_GPIO=y
 CONFIG_MFD_SYSCON=y
 CONFIG_POWER_RESET_SYSCON=y
+CONFIG_REGULATOR_LP872X=y
 CONFIG_REGULATOR_MAX14577=m
 CONFIG_REGULATOR_MAX8907=y
 CONFIG_REGULATOR_MAX8973=y
-- 
2.6.4
