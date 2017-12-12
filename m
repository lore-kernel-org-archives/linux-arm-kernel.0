From: khilman@baylibre.com (Kevin Hilman)
Date: Mon, 11 Dec 2017 16:27:33 -0800
Subject: [GIT PULL] Amlogic 32-bit DT changes for v4.16
Message-ID: <7hr2s0aiyy.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323:

  Linux 4.15-rc1 (2017-11-26 16:01:47 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-amlogic.git tags/amlogic-dt

for you to fetch changes up to 71a3dfd07ce1a69060bf040f28799171aa6a4ed3:

  ARM: meson: enable MESON_IRQ_GPIO also for MACH_MESON8 (2017-12-11 15:58:46 -0800)

----------------------------------------------------------------
Amlogic 32-bit DT changes for v4.16
- meson8: GPIO IRQ support
- switch to stable UART bindings w/correct clock
- add more L2 cache settings
- drop unused ADC clock

----------------------------------------------------------------
Martin Blumenstingl (6):
      ARM: dts: meson8b: add more L2 cache settings
      ARM: dts: meson8: add more L2 cache settings
      ARM: dts: meson8: use stable UART bindings with correct gate clock
      ARM: dts: meson8b: use stable UART bindings with correct gate clock
      ARM: dts: meson8: enable the GPIO interrupt controller
      ARM: meson: enable MESON_IRQ_GPIO also for MACH_MESON8

Xingyu Chen (1):
      ARM: dts: meson: drop "sana" clock from SAR ADC

 arch/arm/boot/dts/meson8.dtsi  | 29 ++++++++++++++++++++++-------
 arch/arm/boot/dts/meson8b.dtsi | 24 +++++++++++++++++-------
 arch/arm/mach-meson/Kconfig    |  1 +
 3 files changed, 40 insertions(+), 14 deletions(-)
