From: khilman@baylibre.com (Kevin Hilman)
Date: Wed, 27 Jun 2018 16:55:30 -0700
Subject: [GIT PULL] Amlogic fixes for v4.18-rc
Message-ID: <7hk1qjhjil.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:

  Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-amlogic.git tags/amlogic-fixes

for you to fetch changes up to 1c38f4afd5d40234b67635b3c608a4093be04b96:

  ARM64: dts: meson-gxl: fix Mali GPU compatible string (2018-06-27 16:48:25 -0700)

----------------------------------------------------------------
Amlogic fixes for v4.18-rc
- minor 64-bit DT fixes

----------------------------------------------------------------
Jerome Brunet (2):
      ARM64: dts: meson: disable sd-uhs modes on the libretech-cc
      ARM64: dts: meson-axg: fix ethernet stability issue

Kevin Hilman (2):
      ARM64: dts: meson: fix register ranges for SD/eMMC
      ARM64: dts: meson-gx: fix ATF reserved memory region

Martin Blumenstingl (1):
      ARM64: dts: meson-gxl: fix Mali GPU compatible string

Neil Armstrong (1):
      ARM64: dts: meson-gxl-s905x-p212: Add phy-supply for usb0

 arch/arm64/boot/dts/amlogic/meson-axg-s400.dts               | 15 ++++++++++++++-
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi                   |  4 ++--
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi                    | 12 +++++++++---
 arch/arm64/boot/dts/amlogic/meson-gxl-mali.dtsi              |  2 +-
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts |  3 ---
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi        |  7 +++++++
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi                   |  8 --------
 7 files changed, 33 insertions(+), 18 deletions(-)
