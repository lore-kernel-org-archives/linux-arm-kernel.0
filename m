From: khilman@baylibre.com (Kevin Hilman)
Date: Tue, 14 Jun 2016 13:52:10 -0700
Subject: [GIT PULL] Amlogic DT 64-bit changes for v4.8
Message-ID: <7hshwfbiit.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 1a695a905c18548062509178b98bc91e67510864:

  Linux 4.7-rc1 (2016-05-29 09:29:24 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-amlogic.git tags/amlogic-dt64

for you to fetch changes up to 6d1a5c9381eb022104442b2e036124f12ac748e4:

  ARM64: dts: amlogic: Enable Reset Controller on GXBB-based platforms (2016-06-01 10:57:35 -0700)

----------------------------------------------------------------
Amlogic DT 64-bit changes for v4.8
- add pinctrl driver and pins for several devices
- add reset driver

----------------------------------------------------------------
Carlo Caione (3):
      ARM64: dts: amlogic: Add hiu and periphs buses
      documentation: Add compatibles for Amlogic Meson GXBB pin controllers
      ARM64: dts: amlogic: Enable pin controller on GXBB-based platforms

Kevin Hilman (3):
      ARM64: dts: amlogic: add pins for EMMC, SD
      ARM64: dts: amlogic: gxbb: pinctrl: add/update UART
      ARM64: dts: amlogic: gxbb: add ethernet

Neil Armstrong (1):
      ARM64: dts: amlogic: Enable Reset Controller on GXBB-based platforms

 Documentation/devicetree/bindings/pinctrl/meson,pinctrl.txt |   2 ++
 arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts         |  20 ++++++++++++
 arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi            |   9 ++++++
 arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi        |   3 ++
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi                 | 159 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 5 files changed, 192 insertions(+), 1 deletion(-)
