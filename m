From: eballetbo@gmail.com (Enric Balletbo i Serra)
Date: Tue, 15 Dec 2015 09:20:51 +0100
Subject: [PATCHv2 1/2] ARM: multi_v7_defconfig: Enable Rockchip generic power
 domain.
Message-ID: <1450167651-5703-1-git-send-email-enric.balletbo@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to meet high performance an low power requirement for Rockchip
enable the power domain support. The patch also fixes a drm/kms issue,
driver deferring untils power-domains are available)

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
---

Changes since last version:

 - Add justification as proposed by Heiko
 - Add to=arm at kernel.org 

 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 69a22fd..81314ec 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -655,6 +655,7 @@ CONFIG_QCOM_PM=y
 CONFIG_QCOM_SMD=y
 CONFIG_QCOM_SMD_RPM=y
 CONFIG_QCOM_SMEM=y
+CONFIG_ROCKCHIP_PM_DOMAINS=y
 CONFIG_COMMON_CLK_QCOM=y
 CONFIG_CHROME_PLATFORMS=y
 CONFIG_CROS_EC_CHARDEV=m
-- 
2.1.0
