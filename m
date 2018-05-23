From: khilman@baylibre.com (Kevin Hilman)
Date: Wed, 23 May 2018 11:17:48 -0700
Subject: [GIT PULL] Amlogic 64-bit DT updates for v4.18, round 2
Message-ID: <7hwovuqlrn.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit c51fb2d458a6d62215c1ff6bbca8e5c876370e71:

  dt-bindings: arm: amlogic: add support for the Tronsmart MXIII Plus (2018-05-09 15:25:20 -0700)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-amlogic.git tags/amlogic-dt64-2

for you to fetch changes up to ffe2f2a415a5c36c0629c0ac8ea3dda80fbfd4b6:

  ARM64: dts: meson-axg: enable i2c AO on the S400 board (2018-05-23 10:05:41 -0700)

----------------------------------------------------------------
Amlogic 64-bit DT updates for v4.18, round 2
- AXG I2C fixups/cleanups

----------------------------------------------------------------
Jerome Brunet (4):
      ARM64: dts: meson-axg: clean-up i2c nodes
      ARM64: dts: meson-axg: correct i2c AO clock
      ARM64: dts: meson-axg: add i2c AO pins
      ARM64: dts: meson-axg: enable i2c AO on the S400 board

 arch/arm64/boot/dts/amlogic/meson-axg-s400.dts |  6 ++++++
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi     | 79 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------------------
 2 files changed, 62 insertions(+), 23 deletions(-)
