From: khilman@baylibre.com (Kevin Hilman)
Date: Tue, 02 Jan 2018 12:16:40 -0800
Subject: [GIT PULL] Amlogic 64-bit DT changes for v4.16, round 2
Message-ID: <7hzi5w2ezb.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof,

Here's a second round of 64-bit DT changes for v4.16.  This branch is on
top of the previous round (already merged.)

This adds a few more basics (clock, pinctrl, PWM, reset) for the new AXG
family of Amlogic SoCs.

Kevin


The following changes since commit 3106507e1004dd398ef75d0caf048f97ba2dfd0b:

  ARM64: dts: meson-gxm: fix q200 interrupt number (2017-12-08 10:47:28 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-amlogic.git tags/amlogic-dt64-2

for you to fetch changes up to 43b9f617b5f98f2f7abb508fef5e535e5fb66a41:

  arm64: dts: meson-axg: add new reset DT node (2017-12-15 16:20:29 -0800)

----------------------------------------------------------------
Amlogic 64-bit DT updates for v4.16, round 2
- clock, pinctrl, PWM and reset nodes for new AXG SoC family

----------------------------------------------------------------
Jian Hu (1):
      ARM64: dts: meson-axg: add PWM DT info for Meson-Axg SoC

Qiufang Dai (1):
      arm64: dts: meson-axg: add clock DT info for Meson AXG SoC

Xingyu Chen (2):
      documentation: Add compatibles for Amlogic Meson AXG pin controllers
      ARM64: dts: meson-axg: add pinctrl DT info for Meson-AXG SoC

Yixun Lan (1):
      arm64: dts: meson-axg: add new reset DT node

 Documentation/devicetree/bindings/pinctrl/meson,pinctrl.txt |   2 +
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi                  | 175 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 177 insertions(+)
