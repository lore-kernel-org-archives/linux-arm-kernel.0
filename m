From: contact@paulk.fr (Paul Kocialkowski)
Date: Fri,  5 Feb 2016 19:42:21 +0100
Subject: [PATCH v2 4/4] ARM: multi_v7_defconfig: Enable LP872x regulator
 support
In-Reply-To: <1454697741-8687-1-git-send-email-contact@paulk.fr>
References: <1454697741-8687-1-git-send-email-contact@paulk.fr>
Message-ID: <1454697741-8687-5-git-send-email-contact@paulk.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The LP872x regulator is used in the LG Optimus Black (P970) codename sniper
to supply the external mmc card.

Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 314f6be..bc44876 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -467,6 +467,7 @@ CONFIG_REGULATOR_RK808=y
 CONFIG_REGULATOR_GPIO=y
 CONFIG_MFD_SYSCON=y
 CONFIG_POWER_RESET_SYSCON=y
+CONFIG_REGULATOR_LP872X=y
 CONFIG_REGULATOR_MAX14577=m
 CONFIG_REGULATOR_MAX8907=y
 CONFIG_REGULATOR_MAX8973=y
-- 
1.9.1
