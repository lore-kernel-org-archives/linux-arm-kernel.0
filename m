From: khilman@baylibre.com (Kevin Hilman)
Date: Mon, 11 Dec 2017 16:28:09 -0800
Subject: [GIT PULL] Amlogic 64-bit DT updates for v4.16
Message-ID: <7hmv2oaixy.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323:

  Linux 4.15-rc1 (2017-11-26 16:01:47 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-amlogic.git tags/amlogic-dt64

for you to fetch changes up to 3106507e1004dd398ef75d0caf048f97ba2dfd0b:

  ARM64: dts: meson-gxm: fix q200 interrupt number (2017-12-08 10:47:28 -0800)

----------------------------------------------------------------
Amlogic 64-bit DT updates for v4.16
- meson-gx: add VPU power domain support
- odroid-c2: add HDMI and CEC nodes
- misc cleanups

----------------------------------------------------------------
Jerome Brunet (1):
      ARM64: dts: meson-gxm: fix q200 interrupt number

Kevin Hilman (1):
      ARM64: dts: amlogic: use generic bus node names

Martin Blumenstingl (2):
      ARM64: dts: meson: add comments with the GPIO for the PHY interrupts
      ARM64: dts: meson-gxm: add the PHY interrupt line on Khadas VIM2

Neil Armstrong (4):
      ARM64: dts: meson-gx: add VPU power domain
      ARM64: dts: meson-gx: Add HDMI_5V regulator on selected boards
      ARM64: dts: meson-gx: grow reset controller memory zone
      ARM64: dts: odroid-c2: Add HDMI and CEC Nodes

Xingyu Chen (1):
      ARM64: dts: meson: drop "sana" clock from SAR ADC

 arch/arm64/boot/dts/amlogic/meson-axg.dtsi                   |  4 ++--
 arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi          | 12 ++++++++++++
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi                    | 19 +++++++++++++++----
 arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts         |  1 +
 arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts          | 32 ++++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/amlogic/meson-gxbb-p200.dts              |  1 +
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi                  | 46 ++++++++++++++++++++++++++++++++++++++++++++--
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts | 12 ++++++++++++
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dtsi        | 12 ++++++++++++
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi                   | 46 ++++++++++++++++++++++++++++++++++++++++++++--
 arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts        | 15 +++++++++++++++
 arch/arm64/boot/dts/amlogic/meson-gxm-q200.dts               |  3 ++-
 12 files changed, 192 insertions(+), 11 deletions(-)
