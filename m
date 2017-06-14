From: khilman@baylibre.com (Kevin Hilman)
Date: Wed, 14 Jun 2017 10:48:26 -0700
Subject: [GIT PULL] Amlogic 32-bit DT updates for v4.13
Message-ID: <7htw3ibgut.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 2ea659a9ef488125eb46da6eb571de5eae5c43f6:

  Linux 4.12-rc1 (2017-05-13 13:19:49 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-amlogic.git tags/amlogic-dt

for you to fetch changes up to 2c323c43a3d619d67bffa57dc7480cfae4c53300:

  ARM: dts: meson8: add and use the real clock controller (2017-06-09 11:21:21 -0700)

----------------------------------------------------------------
Amlogic 32-bit DT changes for v4.13:
- minor reorganization to support different busses
- add/use real clock controller

----------------------------------------------------------------
Carlo Caione (1):
      ARM: dts: meson: Extend L2 cache controller node for Meson8 and Meson8b

Martin Blumenstingl (3):
      ARM: dts: meson: organize devices in their corresponding busses
      ARM: dts: meson8b: inherit meson.dtsi from meson8b.dtsi
      ARM: dts: meson8: add and use the real clock controller

 arch/arm/boot/dts/meson.dtsi   | 178 ++++++++++++++++++++++++++++++++++++++++-------------------------------------
 arch/arm/boot/dts/meson6.dtsi  |   2 -
 arch/arm/boot/dts/meson8.dtsi  | 138 ++++++++++++++++++++++++++++++++++++++++--------------------
 arch/arm/boot/dts/meson8b.dtsi | 214 +++++++++++++++++++++++++++++++++++++++------------------------------------------------------
 4 files changed, 273 insertions(+), 259 deletions(-)
