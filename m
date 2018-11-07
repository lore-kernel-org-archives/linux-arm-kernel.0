From: marc.w.gonzalez@free.fr (Marc Gonzalez)
Date: Wed, 7 Nov 2018 21:17:12 +0100
Subject: [PATCH 6/9] arm64: defconfig: Drop redundant SND_SOC_ROCKCHIP_I2S
In-Reply-To: <8b49a92b-ca92-1fca-cd09-3bcd7a3dcbb9@free.fr>
References: <8b49a92b-ca92-1fca-cd09-3bcd7a3dcbb9@free.fr>
Message-ID: <ef47628d-b52c-c51a-d6c9-0b8eeafc3782@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

SND_SOC_ROCKCHIP_RT5645 selects SND_SOC_ROCKCHIP_I2S

Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
---
 arch/arm64/configs/defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 725b9471b21c..8e181cca0a05 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -493,7 +493,6 @@ CONFIG_SND=y
 CONFIG_SND_SOC=y
 CONFIG_SND_BCM2835_SOC_I2S=m
 CONFIG_SND_SOC_ROCKCHIP=m
-CONFIG_SND_SOC_ROCKCHIP_I2S=m
 CONFIG_SND_SOC_ROCKCHIP_SPDIF=m
 CONFIG_SND_SOC_ROCKCHIP_RT5645=m
 CONFIG_SND_SOC_RK3399_GRU_SOUND=m
-- 
2.17.1
