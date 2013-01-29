From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 29 Jan 2013 21:37:16 +0000
Subject: [GIT PULL] ARM: mvebu cleanup for v3.9 round2
Message-ID: <1359495436.F88c4680.7559@triton>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit b96e1b1c3c5319294edb0970b6d5bf099c0e85eb:

  ARM: Kirkwood: Cleanup unneeded include files (2013-01-12 21:50:10 +0000)

are available in the git repository at:

  git://git.infradead.org/users/jcooper/linux.git tags/cleanup_for_v3.9_round2

for you to fetch changes up to 63a069739a5826ab4007da88b7ec71eb9909271c:

  ARM: dove: cleanup includes (2013-01-29 21:31:36 +0000)

----------------------------------------------------------------
cleanup for v3.9 round2
 - remove unneeded #includes for mach-dove
 - remove unneeded #includes and code for the nsa310

----------------------------------------------------------------
Jason Cooper (1):
      ARM: kirkwood: nsa310: cleanup includes and unneeded code

Sebastian Hesselbarth (1):
      ARM: dove: cleanup includes

 arch/arm/mach-dove/common.c           | 29 +++++++++--------------------
 arch/arm/mach-kirkwood/board-nsa310.c |  9 +--------
 2 files changed, 10 insertions(+), 28 deletions(-)
