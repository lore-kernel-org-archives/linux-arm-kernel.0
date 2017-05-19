From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 19 May 2017 18:04:43 +0200
Subject: [PATCH 1/9] MAINTAINERS: extend mvebu SoC entry with pinctrl drivers
In-Reply-To: <cover.0dd8a92ae74fcec8d0470d0a7016035089e46eed.1495209664.git-series.gregory.clement@free-electrons.com>
References: <cover.0dd8a92ae74fcec8d0470d0a7016035089e46eed.1495209664.git-series.gregory.clement@free-electrons.com>
Message-ID: <93e35a2e47c794d2a74657c56469a42147857f9a.1495209664.git-series.gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There was no entry for the mvebu pinctrl drivers. As they are tightly
linked to the SoCs and there is a lot of common code to support the
various pinctrl of each SoCs, then add a new entry for the mvebu
maintainers.

Reviewed-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f7d568b8f133..42befcdec846 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1496,6 +1496,7 @@ F:	arch/arm/boot/dts/armada*
 F:	arch/arm/boot/dts/kirkwood*
 F:	arch/arm64/boot/dts/marvell/armada*
 F:	drivers/cpufreq/mvebu-cpufreq.c
+F:	drivers/pinctrl/mvebu/
 F:	arch/arm/configs/mvebu_*_defconfig
 
 ARM/Marvell Berlin SoC support
-- 
git-series 0.9.1
