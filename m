From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri,  8 Mar 2013 16:38:23 +0100
Subject: [GIT PULL] Renesas ARM-based SoC fixes for v3.9
Message-ID: <1362757104-7498-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Arnd,

The following changes since commit 6dbe51c251a327e012439c4772097a13df43c5b8:

  Linux 3.9-rc1 (2013-03-03 15:11:05 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git 

for you to fetch changes up to 44e9ac45754a182e8121bf137368452365d4cc4b:

  ARM: shmobile: marzen: Include mmc/host.h (2013-03-08 16:29:23 +0100)

----------------------------------------------------------------
Resolve a build failure present since v3.9-rc1

----------------------------------------------------------------
Simon Horman (1):
      ARM: shmobile: marzen: Include mmc/host.h

 arch/arm/mach-shmobile/board-marzen.c |    1 +
 1 file changed, 1 insertion(+)
