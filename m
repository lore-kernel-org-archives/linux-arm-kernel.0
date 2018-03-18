From: stefan@agner.ch (Stefan Agner)
Date: Sun, 18 Mar 2018 21:34:37 +0100
Subject: [PATCH 2/7] ARM: multi_v7_defconfig: enable thermal driver for i.MX
 devices
In-Reply-To: <20180318203442.19759-1-stefan@agner.ch>
References: <20180318203442.19759-1-stefan@agner.ch>
Message-ID: <20180318203442.19759-2-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the i.MX thermal driver required for i.MX SoC family.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 6395425854cc..608bc85856a1 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -463,6 +463,7 @@ CONFIG_SENSORS_PWM_FAN=m
 CONFIG_SENSORS_INA2XX=m
 CONFIG_CPU_THERMAL=y
 CONFIG_BRCMSTB_THERMAL=m
+CONFIG_IMX_THERMAL=y
 CONFIG_ROCKCHIP_THERMAL=y
 CONFIG_RCAR_THERMAL=y
 CONFIG_ARMADA_THERMAL=y
-- 
2.16.2
