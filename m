From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 18 Jul 2017 11:42:53 +0200
Subject: [GIT PULL] ARM: mvebu: fixes for v4.13 (#1)
Message-ID: <87shhu84iq.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the first pull request for fixes for mvebu for v4.13.

Gregory

The following changes since commit 5771a8c08880cdca3bfb4a3fc6d309d6bba20877:

  Linux v4.13-rc1 (2017-07-15 15:22:10 -0700)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-fixes-4.13-1

for you to fetch changes up to 8d4514173211586c6238629b1ef1e071927735f5:

  ARM: dts: armada-38x: Fix irq type for pca955 (2017-07-18 11:26:30 +0200)

----------------------------------------------------------------
mvebu fixes for 4.13 (part 1)

- Fix wrong irq type for gpio expeander on Armada 388 GP
- Use __pa_symbol instead of virt_to_phys in the mv98dx3236 platform
  SMP code

----------------------------------------------------------------
Gregory CLEMENT (2):
      ARM: mvebu: use __pa_symbol in the mv98dx3236 platform SMP code
      ARM: dts: armada-38x: Fix irq type for pca955

 arch/arm/boot/dts/armada-388-gp.dts | 4 ++--
 arch/arm/mach-mvebu/platsmp.c       | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)
