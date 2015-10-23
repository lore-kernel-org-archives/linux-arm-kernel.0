From: kgene@kernel.org (Kukjin Kim)
Date: Sat, 24 Oct 2015 06:27:56 +0900
Subject: [GIT PULL 5/5] Late Samsung defconfig updates for v4.4
In-Reply-To: <562AA40E.4050407@kernel.org>
References: <562AA40E.4050407@kernel.org>
Message-ID: <562AA65C.7010702@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 6ff33f3902c3b1c5d0db6b1e2c70b6d76fba357f:

  Linux 4.3-rc1 (2015-09-12 16:35:56 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
tags/samsung-defconfig

for you to fetch changes up to f0864f843f0249f3e16e1a9af7152d7aa8070b10:

  ARM: multi_v7_defconfig: Enable rtl8152 ethernet driver for Odroid-XU4
(2015-10-24 04:13:12 +0900)

----------------------------------------------------------------
Samsung defconfig udpates for v4.4

- exynos_defconfig
  : enable USB Video Class for Peach boards.
  : enable DWC2 USB and USB ethernet gadget
  : enable LEDs (LEGS_GPIO and LEDS_PWM)for Odroid-XU3/XU4
  : enable RTL8152 for Odroid-XU4
  : enable WiFi-Ex as a module instead of build-in
  : disable temporal simplefb support (FB_SIMPLE) because
    exynos DRM driver can support it now

- multi_v7_defconfig
  : enable DWC2 USB and USB ethernet gadget
  : enable RTL8152 for Odroid-XU4

----------------------------------------------------------------
Anand Moon (3):
      ARM: exynos_defconfig: Enable LEDS for Odroid-XU3/XU4
      ARM: exynos_defconfig: Enable rtl8152 ethernet driver for Odroid-XU4
      ARM: multi_v7_defconfig: Enable rtl8152 ethernet driver for Odroid-XU4

Javier Martinez Canillas (3):
      ARM: exynos_defconfig: Enable USB Video Class support
      ARM: exynos_defconfig: Disable simplefb support
      ARM: exynos_defconfig: Enable WiFi-Ex as a module instead built-in

Marek Szyprowski (2):
      ARM: exynos_defconfig: Enable DWC2 USB driver and USB ethernet gadget
      ARM: multi_v7_defconfig: Enable DWC2 USB driver and USB ethernet
gadget

 arch/arm/configs/exynos_defconfig   | 18 +++++++++++++++---
 arch/arm/configs/multi_v7_defconfig |  3 +++
 2 files changed, 18 insertions(+), 3 deletions(-)
