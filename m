From: wens@csie.org (Chen-Yu Tsai)
Date: Sun, 25 Jan 2015 20:22:10 +0800
Subject: [PATCH v2 9/9] ARM: multi_v7_defconfig: Enable CONFIG_PHY_SUN9I_USB
In-Reply-To: <1422188530-1794-1-git-send-email-wens@csie.org>
References: <1422188530-1794-1-git-send-email-wens@csie.org>
Message-ID: <1422188530-1794-10-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On sun9i we have a new PHY driver for USB.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index eec304487e6d..63fcc5522393 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -462,6 +462,7 @@ CONFIG_TI_PIPE3=y
 CONFIG_PHY_MIPHY365X=y
 CONFIG_PHY_STIH41X_USB=y
 CONFIG_PHY_SUN4I_USB=y
+CONFIG_PHY_SUN9I_USB=y
 CONFIG_EXT4_FS=y
 CONFIG_AUTOFS4_FS=y
 CONFIG_MSDOS_FS=y
-- 
2.1.4
