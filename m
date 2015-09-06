From: sjoerd.simons@collabora.co.uk (Sjoerd Simons)
Date: Sun,  6 Sep 2015 22:16:04 +0200
Subject: [PATCH 2/4] ARM: multi_v7_defconfig: Enable ACT8865 PMIC driver
In-Reply-To: <1441570566-14001-1-git-send-email-sjoerd.simons@collabora.co.uk>
References: <1441570566-14001-1-git-send-email-sjoerd.simons@collabora.co.uk>
Message-ID: <1441570566-14001-3-git-send-email-sjoerd.simons@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Active Semi act8846 is used as the PMIC on various Rockchip boards,
enable the ACT8865 driver to support this.

Signed-off-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
---

 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 25a1d574..7058fef 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -401,6 +401,7 @@ CONFIG_MFD_TPS65090=y
 CONFIG_MFD_TPS6586X=y
 CONFIG_MFD_TPS65910=y
 CONFIG_REGULATOR_AB8500=y
+CONFIG_REGULATOR_ACT8865=y
 CONFIG_REGULATOR_AS3711=y
 CONFIG_REGULATOR_AS3722=y
 CONFIG_REGULATOR_AXP20X=y
-- 
2.5.1
