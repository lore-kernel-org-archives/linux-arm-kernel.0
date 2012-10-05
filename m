From: gautam.vivek@samsung.com (Vivek Gautam)
Date: Fri, 05 Oct 2012 15:40:16 +0530
Subject: [PATCH 0/2] Enable ehci and ohci devices for exynos5250
Message-ID: <1349431818-15639-1-git-send-email-gautam.vivek@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Based on for-next branch of linux-samsung.

Vivek Gautam (2):
  ARM: Exynos5250: Enabling ehci-s5p driver
  ARM: Exynos5250: Enabling ohci-exynos driver

 .../devicetree/bindings/usb/exynos-usb.txt         |   40 ++++++++++++++++++++
 arch/arm/boot/dts/exynos5250-smdk5250.dts          |    4 ++
 arch/arm/boot/dts/exynos5250.dtsi                  |   12 ++++++
 arch/arm/mach-exynos/include/mach/map.h            |    2 +
 arch/arm/mach-exynos/mach-exynos5-dt.c             |    4 ++
 5 files changed, 62 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/exynos-usb.txt

-- 
1.7.6.5
