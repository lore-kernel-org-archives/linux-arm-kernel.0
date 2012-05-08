From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 8 May 2012 15:12:30 -0400
Subject: [GIT PULL] ARM: kirkwood: fixes for v3.4
Message-ID: <20120508191230.GI15711@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit d48b97b403d23f6df0b990cee652bdf9a52337a3:

  Linux 3.4-rc6 (2012-05-06 15:07:32 -0700)

are available in the git repository at:
  git://git.infradead.org/users/jcooper/linux-kirkwood.git kirkwood_fixes_for_v3.4

Ben Hutchings (1):
      ARM: orion5x: Fix GPIO enable bits for MPP9

Ian Campbell (1):
      ARM: kirkwood: add missing kexec.h include

 arch/arm/mach-kirkwood/board-dt.c |    1 +
 arch/arm/mach-orion5x/mpp.h       |    4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)
