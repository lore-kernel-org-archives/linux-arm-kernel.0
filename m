From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 07 Apr 2016 10:35:45 -0700
Subject: [GIT PULL] ARM: mvebu: fixes for v4.6 (#1)
Message-ID: <87r3ehjp8u.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the first pull request for fixes for mvebu for v4.6.

Gregory

The following changes since commit f55532a0c0b8bb6148f4e07853b876ef73bc69ca:

  Linux 4.6-rc1 (2016-03-26 16:03:24 -0700)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-fixes-4.6-1

for you to fetch changes up to 199831c77c50e6913e893b6bc268ba9f4a9a2bf8:

  ARM: mvebu: Correct unit address for linksys (2016-03-30 11:58:48 +0200)

----------------------------------------------------------------
mvebu fixes for 4.6 (part 1)

- fix USB adress register for Linksys Armada 388 based boards
- fix build warning in mvebu-mbus

----------------------------------------------------------------
Arnd Bergmann (1):
      bus: mvebu-mbus: use %pa to print phys_addr_t

Patrick Uiterwijk (1):
      ARM: mvebu: Correct unit address for linksys

 arch/arm/boot/dts/armada-385-linksys.dtsi | 2 +-
 drivers/bus/mvebu-mbus.c                  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
