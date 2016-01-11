From: tbm@cyrius.com (Martin Michlmayr)
Date: Sun, 10 Jan 2016 20:25:12 -0800
Subject: ARM: mvebu_v5_defconfig: Remove obsolete SND_KIRKWOOD_SOC_T5325
Message-ID: <20160111042512.GA30997@jirafa.cyrius.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The kirkwood-t5325 driver driver was removed in commit 270a85c80c86
("ASoC: kirkwood: Remove unused drivers") in favour of DT based
simple-card equivalents.  Remove the obsolete config option.

Signed-off-by: Martin Michlmayr <tbm@cyrius.com>
---
 arch/arm/configs/mvebu_v5_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/configs/mvebu_v5_defconfig b/arch/arm/configs/mvebu_v5_defconfig
index 824de49..79e6260 100644
--- a/arch/arm/configs/mvebu_v5_defconfig
+++ b/arch/arm/configs/mvebu_v5_defconfig
@@ -108,7 +108,6 @@ CONFIG_SOUND=y
 CONFIG_SND=y
 CONFIG_SND_SOC=y
 CONFIG_SND_KIRKWOOD_SOC=y
-CONFIG_SND_KIRKWOOD_SOC_T5325=y
 CONFIG_SND_SOC_ALC5623=y
 CONFIG_SND_SIMPLE_CARD=y
 CONFIG_REGULATOR=y
-- 
2.1.4

-- 
Martin Michlmayr
http://www.cyrius.com/
