From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 29 Apr 2014 08:21:18 -0400
Subject: [GIT PULL] ARM: mvebu: fixes for v3.15
Message-ID: <20140429122118.GF28159@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Guys,

Not too many fixes so far, but I didn't want to sit on them any longer.
They've already been in -next for over a week.

Please pull.

thx,

Jason.


The following changes since commit c9eaa447e77efe77b7fa4c953bd62de8297fd6c5:

  Linux 3.15-rc1 (2014-04-13 14:18:35 -0700)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-fixes-3.15

for you to fetch changes up to 1cc9d48145b81e307fab94a5cf6ee66ec2f0de60:

  ARM: orion5x: fix target ID for crypto SRAM window (2014-04-17 04:52:26 +0000)

----------------------------------------------------------------
mvebu fixes for v3.15

 - devbus: fix bus-width conversion

 - orion5x: fix target ID for crypto SRAM window

----------------------------------------------------------------
Thomas Petazzoni (2):
      memory: mvebu-devbus: fix the conversion of the bus width
      ARM: orion5x: fix target ID for crypto SRAM window

 arch/arm/mach-orion5x/common.h |  2 +-
 drivers/memory/mvebu-devbus.c  | 15 +++++++++++++--
 2 files changed, 14 insertions(+), 3 deletions(-)
