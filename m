From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 1 Feb 2013 15:51:58 +0000
Subject: [GIT PULL  1/4] ARM: mvebu: cleanup for v3.9
In-Reply-To: <1359733918.Bf7ecc0.22262@triton>
Message-ID: <1359733918.FF53C1.22262@triton>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit b96e1b1c3c5319294edb0970b6d5bf099c0e85eb:

  ARM: Kirkwood: Cleanup unneeded include files

are available in the git repository at:

  git://git.infradead.org/users/jcooper/linux.git tags/cleanup_for_v3.9_round2

for you to fetch changes up to b3af7a1ffd1e5e9ec536a915393b7e07a8793f2a:

  ARM: dove: cleanup includes

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
 arch/arm/mach-kirkwood/board-nsa310.c |  8 +-------
 2 files changed, 10 insertions(+), 27 deletions(-)
