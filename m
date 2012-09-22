From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 22 Sep 2012 13:22:36 -0400
Subject: [GIT PULL V5 2/7] ARM: kirkwood defconfig changes for v3.7
In-Reply-To: <20120922171554.GE5469@titan.lakedaemon.net>
References: <20120922171554.GE5469@titan.lakedaemon.net>
Message-ID: <20120922172236.GG5469@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Depends:
 - Based on v3.6-rc5
 - branches:
    - kirkwood/boards

defconfig:
 - update kirkwood_defconfig via 'make oldconfig'
 - Add all Kirkwood DT boards to the defconfig
 - enable SERIAL_OF_PLATFORM and ORION_WATCHDOG in kirkwood_defconfig

The following changes since commit 0f81bd438bed6af47a01a97d5ecbb23a7e478de6:

  ARM: Dove: allow PCI to be disabled (2012-09-21 17:07:26 +0000)

are available in the git repository at:
  git://git.infradead.org/users/jcooper/linux.git kirkwood/defconfig

Jason Cooper (2):
      ARM: Kirkwood: update defconfig
      ARM: Kirkwood: add DT boards to defconfig

 arch/arm/configs/kirkwood_defconfig |   38 +++++++++++++++++-----------------
 1 files changed, 19 insertions(+), 19 deletions(-)
