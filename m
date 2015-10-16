From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 16 Oct 2015 19:45:27 +0200
Subject: [GIT PULL] ARM: mvebu: soc for v4.4 (#2)
Message-ID: <87vba6g11k.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the second pull request for soc for mvebu for v4.4.

Gregory

The following changes since commit d492cccac28493f26bb70038385a9ef4df19bdee:

  ARM: mvebu: add support to clear shared L2 bit on Armada XP (2015-09-29 15:31:51 +0200)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-soc-4.4-2

for you to fetch changes up to 400b1b26b44f1c5de45bc01873f42c9e776e102e:

  ARM: orion5x: use mac_pton() helper (2015-10-15 09:37:18 +0200)

----------------------------------------------------------------
mvebu soc for 4.4 (part 2)

- Use mac_pton() helper in the oropn5x board instead of duplicating it
- Add the broken-idle option allowing to boot boards with a mistake in
  the hardware design

----------------------------------------------------------------
Andy Shevchenko (1):
      ARM: orion5x: use mac_pton() helper

Vincent Donnefort (1):
      ARM: mvebu: add broken-idle option

 .../devicetree/bindings/arm/coherency-fabric.txt   |  5 ++
 arch/arm/mach-mvebu/pmsu.c                         | 29 ++++++++++--
 arch/arm/mach-orion5x/Kconfig                      |  3 ++
 arch/arm/mach-orion5x/dns323-setup.c               | 53 ++--------------------
 arch/arm/mach-orion5x/tsx09-common.c               | 49 ++------------------
 5 files changed, 41 insertions(+), 98 deletions(-)

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
