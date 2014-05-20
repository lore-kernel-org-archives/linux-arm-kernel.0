From: rahul.sharma@samsung.com (Rahul Sharma)
Date: Tue, 20 May 2014 19:08:47 +0530
Subject: [PATCH 0/2] ARM: dts: add pmu syscon handle to exynos hdmi nodes
Message-ID: <1400593129-21170-1-git-send-email-rahul.sharma@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add PMU syscon handle to HDMI dt node for controlling PHY
Enable/Disable bit.

Patch is dependent for following patch for approval on DT
Bindings:
http://www.mail-archive.com/linux-samsung-soc at vger.kernel.org/msg31106.html

It is based on Kukjin's "for-next" branch.

Rahul Sharma (2):
  ARM: dts: add pmu syscon handle to exynos5250 hdmi
  ARM: dts: add pmu syscon handle to exynos5420 hdmi

 arch/arm/boot/dts/exynos5250.dtsi |    1 +
 arch/arm/boot/dts/exynos5420.dtsi |    1 +
 2 files changed, 2 insertions(+)

-- 
1.7.9.5
