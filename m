From: tbm@cyrius.com (Martin Michlmayr)
Date: Sun, 10 Jan 2016 20:25:40 -0800
Subject: ARM: mvebu_v5_defconfig: Enable sound module needed for OpenRD
Message-ID: <20160111042540.GA31022@jirafa.cyrius.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

OpenRD-Client requires the CS42L51 codec.

Signed-off-by: Martin Michlmayr <tbm@cyrius.com>
---
 arch/arm/configs/mvebu_v5_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/mvebu_v5_defconfig b/arch/arm/configs/mvebu_v5_defconfig
index 79e6260..25c788a 100644
--- a/arch/arm/configs/mvebu_v5_defconfig
+++ b/arch/arm/configs/mvebu_v5_defconfig
@@ -109,6 +109,7 @@ CONFIG_SND=y
 CONFIG_SND_SOC=y
 CONFIG_SND_KIRKWOOD_SOC=y
 CONFIG_SND_SOC_ALC5623=y
+CONFIG_SND_SOC_CS42L51_I2C=y
 CONFIG_SND_SIMPLE_CARD=y
 CONFIG_REGULATOR=y
 CONFIG_REGULATOR_FIXED_VOLTAGE=y
-- 
2.1.4

-- 
Martin Michlmayr
http://www.cyrius.com/
