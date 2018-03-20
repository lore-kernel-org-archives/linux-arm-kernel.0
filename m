From: khilman@baylibre.com (Kevin Hilman)
Date: Tue, 20 Mar 2018 14:44:41 -0700
Subject: [GIT PULL] Amlogic 32-bit DT updates for v4.17, redo
Message-ID: <7h1sgeqv5i.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:

  Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-amlogic.git tags/amlogic-dt-1

for you to fetch changes up to 4e461e62fc987ed5edb82e2a902fd93f4dccae8f:

  ARM: dts: meson8b: the CBUS GPIO controller only has 83 GPIOs (2018-03-20 14:32:31 -0700)

----------------------------------------------------------------
Amlogic 32-bit DT updates for v4.17
- odroid-c1: add microSD, ethernet, USB reset
- add reset controller
- fix requesting GPIOs greater than GPIOZ_3

----------------------------------------------------------------
Emiliano Ingrassia (2):
      ARM: dts: meson8b: extend ethernet controller description
      ARM: dts: meson8b-odroidc1: ethernet support

Linus L?ssing (1):
      ARM: dts: meson8b-odroidc1: add microSD support

Martin Blumenstingl (5):
      ARM: dts: meson8b: grow the reset controller memory zone
      ARM: dts: meson8: add the reset controller
      ARM: dts: meson8: add the USB reset line
      ARM: dts: meson8b: add the I2C clocks
      ARM: dts: meson8b: the CBUS GPIO controller only has 83 GPIOs

 arch/arm/boot/dts/meson8.dtsi          |  9 +++++++++
 arch/arm/boot/dts/meson8b-odroidc1.dts | 88 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/meson8b.dtsi         | 59 +++++++++++++++++++++++++++++++++++++++++++++++++++++++----
 3 files changed, 152 insertions(+), 4 deletions(-)
