From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 22 Dec 2017 11:29:39 +0100
Subject: [PATCH 1/3] ARM: shmobile: defconfig: Enable SGTL5000 audio codec
In-Reply-To: <cover.1513935930.git.horms+renesas@verge.net.au>
References: <cover.1513935930.git.horms+renesas@verge.net.au>
Message-ID: <66d7b080aade3be61f7b41de800215c85a8d3593.1513935930.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Biju Das <biju.das@bp.renesas.com>

The iWave RZ/G1M Q7 carrier board supports I2S audio codec "SGTL5000".

To increase hardware support enable the driver in the shmobile_defconfig
multiplatform configuration.

Signed-off-by: Biju Das <biju.das@bp.renesas.com>
Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/configs/shmobile_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
index 7b4fc0143148..d60dbe1f108f 100644
--- a/arch/arm/configs/shmobile_defconfig
+++ b/arch/arm/configs/shmobile_defconfig
@@ -173,6 +173,7 @@ CONFIG_SND_SOC=y
 CONFIG_SND_SOC_SH4_FSI=y
 CONFIG_SND_SOC_RCAR=y
 CONFIG_SND_SOC_AK4642=y
+CONFIG_SND_SOC_SGTL5000=y
 CONFIG_SND_SOC_WM8978=y
 CONFIG_SND_SIMPLE_SCU_CARD=y
 CONFIG_USB=y
-- 
2.11.0
