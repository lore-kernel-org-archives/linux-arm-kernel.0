From: khilman@baylibre.com (Kevin Hilman)
Date: Sun, 29 Oct 2017 09:50:58 -0700
Subject: [GIT PULL] Amlogic 64-bit DT updates for v4.15, round 2
Message-ID: <7hlgjtq4nh.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 9d59b708500fcb62d28e15b8c6333be620984d8b:

  arm64: dts: meson-axg: add initial A113D SoC DT support (2017-10-19 03:17:07 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-amlogic.git tags/amlogic-dt64-2

for you to fetch changes up to b94d22d94ad226eeea3b6ec4579fb4bf8a199e5c:

  ARM64: dts: meson-gx: add external PHY interrupt on some platforms (2017-10-29 08:44:04 -0700)

----------------------------------------------------------------
Amlogic 64-bit DT updates for v4.15, round 2
- add support for new GPIO IRQ driver

----------------------------------------------------------------
Jerome Brunet (3):
      ARM64: meson: enable MESON_IRQ_GPIO in Kconfig
      ARM64: dts: meson-gx: add gpio interrupt controller
      ARM64: dts: meson-gx: add external PHY interrupt on some platforms

Neil Armstrong (1):
      ARM64: dts: meson-gxbb-odroidc2: fix usb1 power supply

 arch/arm64/Kconfig.platforms                         | 1 +
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi            | 9 +++++++++
 arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts | 2 ++
 arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts  | 3 +++
 arch/arm64/boot/dts/amlogic/meson-gxbb-p200.dts      | 2 ++
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi          | 6 ++++++
 arch/arm64/boot/dts/amlogic/meson-gxl-s905d-p230.dts | 2 ++
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi           | 6 ++++++
 arch/arm64/boot/dts/amlogic/meson-gxm-q200.dts       | 2 ++
 9 files changed, 33 insertions(+)
