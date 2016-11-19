From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Sat, 19 Nov 2016 09:38:29 +0100
Subject: [GIT PULL] ARM: mvebu: soc for v4.10 (#1)
Message-ID: <874m33ampm.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the first pull request for soc for mvebu for v4.10.

On this PR there is only the removal part of the orion5x platform whcih
was initially part of the "ARM: dt: orion5x: convert ls-chl to FDT"
patch.

Gregory

The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:

  Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-soc-4.10-1

for you to fetch changes up to ecfe69639157b6f70f53a7bc250efb4614c0eb31:

  ARM: orion5x: remove legacy support of ls-chl (2016-11-19 09:14:28 +0100)

----------------------------------------------------------------
mvebu soc for 4.10 (part 1)

remove legacy support of orion5x ls-chl

----------------------------------------------------------------
Ashley Hughes (1):
      ARM: orion5x: remove legacy support of ls-chl

 arch/arm/mach-orion5x/Kconfig        |   7 -
 arch/arm/mach-orion5x/Makefile       |   1 -
 arch/arm/mach-orion5x/ls-chl-setup.c | 331 -----------------------------------
 3 files changed, 339 deletions(-)
 delete mode 100644 arch/arm/mach-orion5x/ls-chl-setup.c
