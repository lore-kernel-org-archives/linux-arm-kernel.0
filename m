From: chanho61.park@samsung.com (Chanho Park)
Date: Mon, 14 Apr 2014 21:48:16 +0900
Subject: [PATCH 0/4] Enable usbphy and hsotg for exynos4
Message-ID: <1397479700-15864-1-git-send-email-chanho61.park@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset enables a exynos4 usbphy and hsotg DT node for exynos4. The usb
phy node uses generic exynos phy driver. The driver uses PMU syscon and SYSREG
syscon phandles.

Chanho Park (4):
  ARM: dts: exynos4: add PMU syscon node
  ARM: dts: exynos4: add exynos_usbphy node
  ARM: dts: exynos4: add hsotg device node
  ARM: dts: exynos4412-trats2: enable usb nodes

 arch/arm/boot/dts/exynos4.dtsi          | 26 ++++++++++++++++++++++++++
 arch/arm/boot/dts/exynos4412-trats2.dts | 10 ++++++++++
 arch/arm/boot/dts/exynos4x12.dtsi       |  5 +++++
 3 files changed, 41 insertions(+)

-- 
1.8.3.2
