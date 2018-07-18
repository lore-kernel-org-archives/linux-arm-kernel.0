From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 18 Jul 2018 17:26:40 +0200
Subject: [GIT PULL v2] ARM: mvebu: arm for v4.19 (#1)
Message-ID: <87zhyo8szz.fsf@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the first pull request for arm for mvebu for v4.19. It
supersedes the previous one done one week ago.

Gregory

The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:

  Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the Git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-arm-4.19-1

for you to fetch changes up to 77bc8c28ddac90287bc42c129002eb703288d550:

  ARM: mvebu: convert secondary CPU clock sync to hotplug state (2018-06-27 08:40:29 +0200)

----------------------------------------------------------------
mvebu arm for 4.19 (part 1)

 - remove potential call from invalid context in boot_secondary
 - allow using CONFIG_FORTIFY_SOURCE in pmsu.c

----------------------------------------------------------------
Ethan Tuttle (1):
      ARM: mvebu: declare asm symbols as character arrays in pmsu.c

Lucas Stach (1):
      ARM: mvebu: convert secondary CPU clock sync to hotplug state

 arch/arm/mach-mvebu/platsmp.c | 49 ++++++++++++++++++++-----------------------
 arch/arm/mach-mvebu/pmsu.c    |  6 +++---
 include/linux/cpuhotplug.h    |  1 +
 3 files changed, 27 insertions(+), 29 deletions(-)
