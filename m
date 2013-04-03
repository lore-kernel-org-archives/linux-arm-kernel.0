From: festevam@gmail.com (Fabio Estevam)
Date: Wed,  3 Apr 2013 20:30:41 -0300
Subject: [PATCH v2 3/3] ARM: mxs_defconfig: Enable CONFIG_RESET_GPIO
In-Reply-To: <1365031841-3864-1-git-send-email-festevam@gmail.com>
References: <1365031841-3864-1-git-send-email-festevam@gmail.com>
Message-ID: <1365031841-3864-3-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

CONFIG_RESET_GPIO is required in order to enable a GPIO to turn on a LCD, for
example.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v1:
- No changes

 arch/arm/configs/mxs_defconfig |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/mxs_defconfig b/arch/arm/configs/mxs_defconfig
index b5f6e55..d2c4105 100644
--- a/arch/arm/configs/mxs_defconfig
+++ b/arch/arm/configs/mxs_defconfig
@@ -147,6 +147,8 @@ CONFIG_COMMON_CLK_DEBUG=y
 CONFIG_IIO=y
 CONFIG_PWM=y
 CONFIG_PWM_MXS=y
+CONFIG_RESET_CONTROLLER=y
+CONFIG_RESET_GPIO=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT2_FS_XATTR=y
 CONFIG_EXT3_FS=y
-- 
1.7.9.5
