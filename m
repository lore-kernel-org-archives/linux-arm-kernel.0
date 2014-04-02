From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Wed, 02 Apr 2014 17:02:55 +0900
Subject: [PATCH 0/3] Add PMU node for Exynos4210, Exynos4412, Exynos4212
Message-ID: <1396425778-4379-1-git-send-email-pankaj.dubey@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch updates Exynos4210, Exynos4412 and Exynos4212 dtsi files
for adding PMU (Power Management Unit) reg node. Also updated binding
document for the same. 
These patches required for using PMU base address via DT for these SoC.
Patches for using PMU base address via DT are posted here-

http://www.mail-archive.com/linux-samsung-soc at vger.kernel.org/msg27875.html

Pankaj Dubey (3):
  ARM: dts: Add PMU reg node to exynos4210
  ARM: dts: Add PMU reg node to exynos4212 and exynos4412
  Documentation: update samsung pmu binding information for
    Exynos4210/4212/4412

 Documentation/devicetree/bindings/arm/samsung/pmu.txt |    3 +++
 arch/arm/boot/dts/exynos4210.dtsi                     |    5 +++++
 arch/arm/boot/dts/exynos4212.dtsi                     |    5 +++++
 arch/arm/boot/dts/exynos4412.dtsi                     |    5 +++++
 4 files changed, 18 insertions(+)

-- 
1.7.10.4
