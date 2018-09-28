From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 28 Sep 2018 12:21:34 +0200
Subject: [PATCH 1/6] ARM: shmobile: defconfig: Remove SOC_CAMERA
In-Reply-To: <cover.1538122547.git.horms+renesas@verge.net.au>
References: <cover.1538122547.git.horms+renesas@verge.net.au>
Message-ID: <f7be103571e8085a363d47b911560a261a440fd4.1538122547.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jacopo Mondi <jacopo@jmondi.org>

As the soc_camera framework is going to be deprecated soon, remove the
associated configuration options from shmobile defconfig.

Signed-off-by: Jacopo Mondi <jacopo@jmondi.org>
Acked-by: Hans Verkuil <hans.verkuil@cisco.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/configs/shmobile_defconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
index f8faf3729464..c8f2cb9fc7f3 100644
--- a/arch/arm/configs/shmobile_defconfig
+++ b/arch/arm/configs/shmobile_defconfig
@@ -129,8 +129,6 @@ CONFIG_MEDIA_CAMERA_SUPPORT=y
 CONFIG_MEDIA_CONTROLLER=y
 CONFIG_VIDEO_V4L2_SUBDEV_API=y
 CONFIG_V4L_PLATFORM_DRIVERS=y
-CONFIG_SOC_CAMERA=y
-CONFIG_SOC_CAMERA_PLATFORM=y
 CONFIG_VIDEO_RCAR_VIN=y
 CONFIG_V4L_MEM2MEM_DRIVERS=y
 CONFIG_VIDEO_RENESAS_JPU=y
-- 
2.11.0
