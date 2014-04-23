From: gautam.vivek@samsung.com (Vivek Gautam)
Date: Wed, 23 Apr 2014 20:59:26 +0530
Subject: [PATCH 0/3] dts: exynos5: Add required VDD supplies for USB
Message-ID: <1398266969-26000-1-git-send-email-gautam.vivek@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Based on for-next branch of Kgene's linux-samsung tree, with
following patch series:
[PATCH 0/9] Enable USB 3.0 support on Exynos5 systems
https://lkml.org/lkml/2014/4/23/389

These are device tree patches corresponding to the usb driver patch-series:
[PATCH 1/3] usb: ohci-exynos: Make provision for vdd regulators
[PATCH 2/3] usb: ehci-exynos: Make provision for vdd regulators
[PATCH 3/3] usb: dwc3-exynos: Make provision for vdd regulators

Vivek Gautam (3):
  dts: exynos5250: Add required VDD regulator supplies for usb
  dts: exynos5250-snow: Add required VDD regulator supplies for usb
  dts: exynos5420-smdk5420: Add required VDD regulator supplies for usb

 arch/arm/boot/dts/exynos5250-smdk5250.dts |   12 ++++++++++++
 arch/arm/boot/dts/exynos5250-snow.dts     |   12 ++++++++++++
 arch/arm/boot/dts/exynos5420-smdk5420.dts |   20 ++++++++++++++++++++
 3 files changed, 44 insertions(+)

-- 
1.7.10.4
