From: jason@lakedaemon.net (Jason Cooper)
Date: Sun, 23 Jun 2013 18:06:18 -0400
Subject: [GIT PULL] ARM: mvebu: fixes-non-critical v3.11 (round 2)
Message-ID: <20130623220618.GX31667@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof,

Got a late bloomer this weekend.  Thanks to Ezequiel for spotting this
and providing a fix.


The following changes since commit cf8088c5cac6ce20d914b9131533844b9291a054:

  arm: mvebu: fix length of Ethernet registers area in .dtsi (2013-05-28 14:48:28 +0000)

are available in the git repository at:

  git://git.infradead.org/users/jcooper/linux.git tags/fixes-non-3.11-2

for you to fetch changes up to cdd8e498c92abd63878a5c1380217fb870ab1872:

  ARM: mvebu: fix length of ethernet registers in mv78260 dtsi (2013-06-23 21:46:12 +0000)

----------------------------------------------------------------
mvebu fixes non-critical for v3.11 (round 2)

 - mvebu
    - mv78260: catch missing fix for mvneta register length

----------------------------------------------------------------
Ezequiel Garcia (1):
      ARM: mvebu: fix length of ethernet registers in mv78260 dtsi

 arch/arm/boot/dts/armada-xp-mv78260.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
