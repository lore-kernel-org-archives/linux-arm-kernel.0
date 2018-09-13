From: khilman@baylibre.com (Kevin Hilman)
Date: Thu, 13 Sep 2018 11:06:26 -0700
Subject: [GIT PULL] Amlogic ARM64 DT updates for v4.20
Message-ID: <7hva79uva5.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-amlogic.git tags/amlogic-dt64

for you to fetch changes up to 445f2bda3501508b801b3571baee33de0ac44e1f:

  arm64: dts: meson: Switch simple-mfd and syscon order (2018-09-13 09:16:36 -0700)

----------------------------------------------------------------
Amlogic ARM64 DT updates for v4.20
- AXG: cleanup/reorder nodes
- AXG: add audio PDM support for s400 board
- GX: increase CMA memory size
- GX: new canvas driver

----------------------------------------------------------------
Christian Hewitt (1):
      arm64: dts: meson-gx: increase default shared CMA pool size

Jerome Brunet (8):
      arm64: dts: meson-axg: add audio fifos
      arm64: dts: meson-axg: s400: enable audio devices
      arm64: dts: meson-axg: s400: add sound card
      arm64: dts: meson-axg: sort nodes consistently
      arm64: dts: meson: libretech: update board model
      arm64: dts: meson-axg: add pdm
      arm64: dts: meson-axg: s400: add dmic codec
      arm64: dts: meson-axg: s400: add pdm to the sound card

Maxime Jourdan (1):
      arm64: dts: meson-gx: add dmcbus and canvas nodes.

Neil Armstrong (3):
      arm64: dts: meson-axg: use the proper compatible for ethmac
      arm64: dts: meson-axg-s400: Add chosen and memory nodes
      arm64: dts: meson: Switch simple-mfd and syscon order

 arch/arm64/boot/dts/amlogic/meson-axg-s400.dts               |  368 +++++++++++---
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi                   | 1615 ++++++++++++++++++++++++++++++++-----------------------------
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi                    |   19 +-
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts |    2 +-
 4 files changed, 1156 insertions(+), 848 deletions(-)
