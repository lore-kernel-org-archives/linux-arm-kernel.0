From: khilman@baylibre.com (Kevin Hilman)
Date: Mon, 12 Feb 2018 16:19:38 -0800
Subject: [GIT PULL] Amlogic fixes for v4.16-rc2
Message-ID: <7h8tbxagh1.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof,

Here are a couple small DT-only fixes for v4.16-rc.

Please pull,

Thanks,

Kevin


The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:

  Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-amlogic.git tags/amlogic-fixes

for you to fetch changes up to 77f5cdbd78ec5e17022725a5da476f4ca08b1dfa:

  ARM64: dts: meson: uart: fix address space range (2018-02-12 14:13:04 -0800)

----------------------------------------------------------------
Amlogic fixes for v4.16-rc1
- DT: fix UART address ranges
- DT: enable PHY interrupts

----------------------------------------------------------------
Jerome Brunet (1):
      ARM64: dts: meson-gxl: add internal ethernet PHY irq

Yixun Lan (1):
      ARM64: dts: meson: uart: fix address space range

 arch/arm64/boot/dts/amlogic/meson-axg.dtsi |  4 ++--
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi  | 10 +++++-----
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi |  1 +
 3 files changed, 8 insertions(+), 7 deletions(-)
