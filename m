From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 30 Aug 2012 13:14:28 -0400
Subject: [GIT PULL] kirkwood fix for v3.6
Message-ID: <20120830171428.GT19437@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit b74ffd85e32d44e8ed405a2a0a175ef4cd39cf67:

  ARM: Kirkwood: fix Makefile.boot (2012-08-15 13:58:52 +0000)

are available in the git repository at:
  git://git.infradead.org/users/jcooper/linux.git fixes-for-v3.6

Andrew Lunn (1):
      ARM: Kirkwood: Fix 'SZ_1M' undeclared here for db88f6281-bp-setup.c

 arch/arm/mach-kirkwood/db88f6281-bp-setup.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)
