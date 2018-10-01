From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 01 Oct 2018 11:48:08 +0200
Subject: [GIT PULL] ARM: mvebu: soc for v4.20 (#1)
Message-ID: <87r2hangkn.fsf@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the first pull request for soc for mvebu for v4.20.

Gregory

The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the Git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-soc-4.20-1

for you to fetch changes up to 40ad192f9e88d1376320399e49b9d978b56a9477:

  dt-bindings: marvell,prestera: Add common compatible string (2018-09-24 17:16:54 +0200)

----------------------------------------------------------------
mvebu soc for 4.20 (part 1)

 - use dt_fixup to provide fallback for enable-method for Armada XP
 - document the marvell,prestera compatible string
 - update Thomas Petazzoni email in MAINTAINERS file

----------------------------------------------------------------
Chris Packham (2):
      ARM: mvebu: use dt_fixup to provide fallback for enable-method
      dt-bindings: marvell,prestera: Add common compatible string

Thomas Petazzoni (1):
      MAINTAINERS: replace free-electrons.com by bootlin.com for Thomas Petazzoni

 Documentation/devicetree/bindings/net/marvell,prestera.txt |  4 ++--
 MAINTAINERS                                                |  8 ++++----
 arch/arm/mach-mvebu/board-v7.c                             | 14 ++++++++------
 3 files changed, 14 insertions(+), 12 deletions(-)
