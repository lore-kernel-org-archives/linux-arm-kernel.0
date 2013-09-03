From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 3 Sep 2013 08:24:49 -0400
Subject: [GIT PULL] ARM: mvebu: fixes-non-critical for v3.12 (last one)
Message-ID: <20130903122449.GF19598@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof, Kevin,

Here's the last mvebu/fixes-non-critical pull for v3.12, these came in
late and have been in -next for about a week.

thx,

Jason.


The following changes since commit 35faad2a1563b3d4dc983a82ac41033fe053870c:

  ARM: dts: Fix memory node in skeleton64.dtsi (2013-08-07 16:33:50 +0000)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/fixes-non-3.12-3

for you to fetch changes up to 4e611ae7ef492fd857f64827efda3eea09f75233:

  bus: mvebu: add missing of_node_put() to fix reference leak (2013-08-27 14:33:38 +0000)

----------------------------------------------------------------
mvebu fixes-non-critical for v3.12 (round 3)

 - mvebu
    - fix reference leaks by adding missing of_node_put()'s.

----------------------------------------------------------------
Jisheng Zhang (2):
      arm: mvebu: add missing of_node_put() to fix reference leak
      bus: mvebu: add missing of_node_put() to fix reference leak

 arch/arm/mach-mvebu/armada-370-xp.c     | 1 +
 arch/arm/mach-mvebu/coherency.c         | 8 +++++++-
 arch/arm/mach-mvebu/platsmp.c           | 1 +
 arch/arm/mach-mvebu/pmsu.c              | 1 +
 arch/arm/mach-mvebu/system-controller.c | 1 +
 drivers/bus/mvebu-mbus.c                | 6 +++++-
 6 files changed, 16 insertions(+), 2 deletions(-)
