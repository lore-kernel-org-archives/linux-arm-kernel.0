From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 28 May 2013 10:56:22 -0400
Subject: [GIT PULL v2] ARM: mvebu: fixes for v3.10 (round 3)
In-Reply-To: <20130527185436.GN31290@titan.lakedaemon.net>
References: <20130527185436.GN31290@titan.lakedaemon.net>
Message-ID: <20130528145622.GS31290@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Olof,

Updated to move two non-critical patches to mvebu/fixes-non-critical


The following changes since commit 489e138eec96f529c5e8d4cd3ea45882ecdbf5ca:

  ARM: dts: mvebu: Fix wrong the address reg value for the L2-cache node (2013-05-20 17:44:54 +0000)

are available in the git repository at:

  git://git.infradead.org/users/jcooper/linux.git tags/fixes-3.10-3

for you to fetch changes up to b60b61d41220c8d34e2c62a748bc78bc5d40585e:

  ARM: mvebu: Fix bug in coherency fabric low level init function (2013-05-28 14:50:08 +0000)

----------------------------------------------------------------
mvebu fixes for v3.10 round 3

 - mvebu
    - fix bug in coherency fabric low level init

 - kirkwood
    - fix crash from pcie double init

----------------------------------------------------------------
Andrew Lunn (1):
      ARM: Kirkwood: TS219: Fix crash by double PCIe instantiation

Nadav Haklai (1):
      ARM: mvebu: Fix bug in coherency fabric low level init function

 arch/arm/mach-kirkwood/board-ts219.c | 10 ----------
 arch/arm/mach-mvebu/coherency_ll.S   | 16 +++++++++++-----
 2 files changed, 11 insertions(+), 15 deletions(-)
