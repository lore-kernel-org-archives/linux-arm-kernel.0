From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 26 Nov 2015 21:52:44 +0100
Subject: [GIT PULL] ARM: mvebu: fixes for v4.4 (#1)
Message-ID: <87bnag8ov7.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the first pull request for fixes for mvebu for v4.4.

Gregory

The following changes since commit 8005c49d9aea74d382f474ce11afbbc7d7130bec:

  Linux 4.4-rc1 (2015-11-15 17:00:27 -0800)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-fixes-4.4-1

for you to fetch changes up to 4d2ec7e206ae03a51dfbdedc120ce88d403ec926:

  ARM: orion5x: Fix legacy get_irqnr_and_base (2015-11-25 15:01:00 +0000)

----------------------------------------------------------------
mvebu fixes for 4.4 (part 1)

- Fix QNAP TS219 power-off in dts
- Fix legacy get_irqnr_and_base for dove and orion5x

----------------------------------------------------------------
Helmut Klein (1):
      ARM: dts: Kirkwood: Fix QNAP TS219 power-off

Nicolas Pitre (2):
      ARM: dove: Fix legacy get_irqnr_and_base
      ARM: orion5x: Fix legacy get_irqnr_and_base

 arch/arm/boot/dts/kirkwood-ts219.dtsi            | 2 +-
 arch/arm/mach-dove/include/mach/entry-macro.S    | 4 ++--
 arch/arm/mach-orion5x/include/mach/entry-macro.S | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
