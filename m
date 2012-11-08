From: gautam.vivek@samsung.com (Vivek Gautam)
Date: Thu, 08 Nov 2012 14:02:12 +0530
Subject: [PATCH v2] ARM: EXYNOS5250: Add support for USB 3.0 dwc3 controller
Message-ID: <1352363533-14970-1-git-send-email-gautam.vivek@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes from v1:
 - Changed the device node name from 'dwc3' to 'usb at 12000000'.
 - Added the documentation for device tree bindings for dwc3 controller.

Based on changes for USB 2.0:
'https://lists.ozlabs.org/pipermail/devicetree-discuss/2012-November/022046.html'

Tested with required driver DT patches for dwc3-exynos:
http://www.spinics.net/lists/linux-usb/msg73857.html
and USB 3.0 phy support patches:
https://lists.ozlabs.org/pipermail/devicetree-discuss/2012-November/021926.html

Vivek Gautam (1):
  ARM: Exynos5250: Enabling dwc3-exynos driver

 .../devicetree/bindings/usb/exynos-usb.txt         |   14 +++++++++++
 arch/arm/boot/dts/exynos5250.dtsi                  |    6 +++++
 arch/arm/mach-exynos/Kconfig                       |    1 +
 arch/arm/mach-exynos/clock-exynos5.c               |   24 ++++++++++++++++++++
 arch/arm/mach-exynos/include/mach/map.h            |    1 +
 arch/arm/mach-exynos/mach-exynos5-dt.c             |    2 +
 6 files changed, 48 insertions(+), 0 deletions(-)

-- 
1.7.6.5
