From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 22 Sep 2012 13:27:56 -0400
Subject: [GIT PULL V5 4/7] ARM: kirkwood cleanup changes for v3.7
In-Reply-To: <20120922171554.GE5469@titan.lakedaemon.net>
References: <20120922171554.GE5469@titan.lakedaemon.net>
Message-ID: <20120922172756.GI5469@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Depends:
 - Based on v3.6-rc5
 - kirkwood/dt (gpio-fan bindings caused removal of includes in
   board-dnskw.c)

Misc:
 - trim includes for board-dnskw.c

The following changes since commit 1b90e06b14291ce3c252bd10e4ce981a08152e2e:

  ARM: kirkwood: Use devicetree to define DNS-32[05] fan (2012-09-22 14:40:58 +0000)

are available in the git repository at:
  git://git.infradead.org/users/jcooper/linux.git kirkwood/cleanup

Jamie Lentin (1):
      ARM: kirkwood: Trim excess #includes in board-dnskw.c

 arch/arm/mach-kirkwood/board-dnskw.c |    9 ---------
 1 files changed, 0 insertions(+), 9 deletions(-)
