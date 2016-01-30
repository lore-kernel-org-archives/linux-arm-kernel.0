From: festevam@gmail.com (Fabio Estevam)
Date: Sat, 30 Jan 2016 12:35:08 -0200
Subject: [PATCH 2/2] ARM: mxs_defconfig: Select CONFIG_NVMEM_MXS_OCOTP
In-Reply-To: <1454164508-10831-1-git-send-email-festevam@gmail.com>
References: <1454164508-10831-1-git-send-email-festevam@gmail.com>
Message-ID: <1454164508-10831-2-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

Select the mxs ocotp driver.

Cc: Stefan Wahren <stefan.wahren@i2se.com>
Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/configs/mxs_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/mxs_defconfig b/arch/arm/configs/mxs_defconfig
index b47e7c6..1b2d9b3 100644
--- a/arch/arm/configs/mxs_defconfig
+++ b/arch/arm/configs/mxs_defconfig
@@ -141,6 +141,8 @@ CONFIG_IIO=y
 CONFIG_IIO_SYSFS_TRIGGER=y
 CONFIG_PWM=y
 CONFIG_PWM_MXS=y
+CONFIG_NVMEM=y
+CONFIG_NVMEM_MXS_OCOTP=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT2_FS_XATTR=y
 CONFIG_EXT3_FS=y
-- 
1.9.1
