From: ray.jui@broadcom.com (Ray Jui)
Date: Wed, 23 May 2018 13:32:07 -0700
Subject: [PATCH v2 6/6] arm64: defconfig: add CONFIG_ARM_SP805_WATCHDOG
In-Reply-To: <1527107527-8093-1-git-send-email-ray.jui@broadcom.com>
References: <1527107527-8093-1-git-send-email-ray.jui@broadcom.com>
Message-ID: <1527107527-8093-7-git-send-email-ray.jui@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the SP805 watchdog timer

Signed-off-by: Ray Jui <ray.jui@broadcom.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index ecf6137..3fe5eb5 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -351,6 +351,7 @@ CONFIG_ROCKCHIP_THERMAL=m
 CONFIG_TEGRA_BPMP_THERMAL=m
 CONFIG_UNIPHIER_THERMAL=y
 CONFIG_WATCHDOG=y
+CONFIG_ARM_SP805_WATCHDOG=y
 CONFIG_S3C2410_WATCHDOG=y
 CONFIG_MESON_GXBB_WATCHDOG=m
 CONFIG_MESON_WATCHDOG=m
-- 
2.1.4
