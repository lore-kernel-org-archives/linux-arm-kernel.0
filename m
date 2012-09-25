From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 24 Sep 2012 20:00:13 -0400
Subject: [GIT PULL] orion5x late fixes for v3.6 (or v3.7 if too late)
Message-ID: <20120925000013.GV5469@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Depends:
 - Based on v3.6-rc7

This same fix was applied to v3.6 earlier in the release cycle for
kirkwood.  orion5x suffers from the same problem.

No problem if it's too late for v3.6.  We can apply it to v3.7-rc1 and
then apply it to stable v3.6.1.

The following changes since commit 979570e02981d4a8fc20b3cc8fd651856c98ee9d:

  Linux 3.6-rc7 (2012-09-23 18:10:57 -0700)

are available in the git repository at:
  git://git.infradead.org/users/jcooper/linux.git kirkwood/late-fixes

Andrew Lunn (1):
      ARM: Orion5x: Fix too small coherent pool.

 arch/arm/mach-orion5x/common.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)
