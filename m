From: contact@paulk.fr (Paul Kocialkowski)
Date: Wed, 23 Dec 2015 11:58:39 +0100
Subject: [PATCH 6/6] ARM: multi_v7_defconfig: Enable LP872x regulator support
In-Reply-To: <1450868319-20513-1-git-send-email-contact@paulk.fr>
References: <1450868319-20513-1-git-send-email-contact@paulk.fr>
Message-ID: <1450868319-20513-7-git-send-email-contact@paulk.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The LP872x regulator is used in the LG Optimus Black (P970) codename sniper
to supply the external mmc card.

Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 69a22fd..e2c01f0 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -425,6 +425,7 @@ CONFIG_REGULATOR_RK808=y
 CONFIG_REGULATOR_GPIO=y
 CONFIG_MFD_SYSCON=y
 CONFIG_POWER_RESET_SYSCON=y
+CONFIG_REGULATOR_LP872X=y
 CONFIG_REGULATOR_MAX14577=m
 CONFIG_REGULATOR_MAX8907=y
 CONFIG_REGULATOR_MAX8973=y
-- 
1.9.1
