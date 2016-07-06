From: khilman@baylibre.com (Kevin Hilman)
Date: Wed, 06 Jul 2016 15:50:06 -0700
Subject: [GIT PULL] Amlogic DT 64-bit updates for v4.8 (#2)
Message-ID: <m237nmqt41.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is the 2nd round of 64-bit DT updates for Amlogic.  Please pull.

Thanks,

Kevin




The following changes since commit 6d1a5c9381eb022104442b2e036124f12ac748e4:

  ARM64: dts: amlogic: Enable Reset Controller on GXBB-based platforms (2016-06-01 10:57:35 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-amlogic.git tags/amlogic-dt64-2

for you to fetch changes up to f3abd6296168d9d356192b50a92a7a980ca99a2f:

  ARM64: DTS: meson-gxbb: switch ethernet to real clock (2016-06-23 15:59:31 -0700)

----------------------------------------------------------------
Amlogic 64-bit DT updates
- add RNG and new clock driver support

----------------------------------------------------------------
Kevin Hilman (1):
      ARM64: DTS: meson-gxbb: switch ethernet to real clock

Michael Turquette (1):
      arm64: dts: gxbb clock controller

Neil Armstrong (2):
      dt-bindings: hwrng: Add Amlogic Meson Hardware Random Generator bindings
      ARM64: dts: meson-gxbb: Add Hardware Random Generator node

 Documentation/devicetree/bindings/rng/amlogic,meson-rng.txt | 14 ++++++++++++++
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi                 | 14 +++++++++++++-
 2 files changed, 27 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/rng/amlogic,meson-rng.txt
