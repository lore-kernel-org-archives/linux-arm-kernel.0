From: khilman@baylibre.com (Kevin Hilman)
Date: Sun, 29 Oct 2017 09:45:58 -0700
Subject: [GIT PULL] Amlogic 32-bit DT updates for v4.15, round 2
Message-ID: <7hpo95q4vt.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 88b1b18ffeae1d65e22ec24040545a84c3ace352:

  ARM: dts: meson: add the SDIO MMC controller (2017-10-11 17:18:25 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-amlogic.git tags/amlogic-dt-2

for you to fetch changes up to 2cb51a8ddd69dbd9e6b3d19dfdacd4ebfdd166a8:

  ARM: dts: meson: add the efuse node (2017-10-29 09:00:38 -0700)

----------------------------------------------------------------
Amlogic 32-bit DT updates for v4.15, round 2
- enable new GPIO IRQ controller
- add efuse node

----------------------------------------------------------------
Carlo Caione (1):
      ARM: dts: meson8b: add support for booting the secondary CPU cores

Jerome Brunet (1):
      ARM: dts: meson8b: enable gpio interrupt controller

Martin Blumenstingl (2):
      ARM: dts: meson8: add support for booting the secondary CPU cores
      ARM: dts: meson: add the efuse node

 arch/arm/boot/dts/meson.dtsi   | 24 ++++++++++++++++++++++++
 arch/arm/boot/dts/meson6.dtsi  |  3 +++
 arch/arm/boot/dts/meson8.dtsi  | 27 +++++++++++++++++++++++++++
 arch/arm/boot/dts/meson8b.dtsi | 34 ++++++++++++++++++++++++++++++++++
 4 files changed, 88 insertions(+)
