From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 22 Sep 2017 11:09:08 +0200
Subject: [GIT PULL] ARM: mvebu: fixes for v4.14 (#1)
Message-ID: <87wp4rksln.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the first pull request for fixes for mvebu for v4.14.

The MAINTAINER patch should have been merged but I missed it when I
rebased my arm64 branch on v4.13-rc1. I move it in the fixes branche
because it is always good to be up to date for this file, and I saw
that in the past you applied this change as a fix.

Gregory

The following changes since commit 2bd6bf03f4c1c59381d62c61d03f6cc3fe71f66e:

  Linux 4.14-rc1 (2017-09-16 15:47:51 -0700)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-fixes-4.14-1

for you to fetch changes up to 9e7460fc325dad06d2066abdbc1f4dd49456f9a4:

  arm64: dt marvell: Fix AP806 system controller size (2017-09-19 16:40:07 +0200)

----------------------------------------------------------------
mvebu fixes for 4.14 (part 1)

Update MAINTAINERS for the Macchiatobin board (Armada 8K based)
Fix AP806 system controller size on Armada 7K/8K

----------------------------------------------------------------
Baruch Siach (1):
      arm64: dt marvell: Fix AP806 system controller size

Russell King (1):
      MAINTAINERS: add Macchiatobin maintainers entry

 MAINTAINERS                                   | 6 ++++++
 arch/arm64/boot/dts/marvell/armada-ap806.dtsi | 4 ++--
 2 files changed, 8 insertions(+), 2 deletions(-)
