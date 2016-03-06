From: olof@lixom.net (Olof Johansson)
Date: Sun, 6 Mar 2016 14:09:51 -0800
Subject: [GIT PULL] ARM: SoC fix for 4.5
Message-ID: <20160306220951.GA24899@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

The following changes since commit fc77dbd34c5c99bce46d40a2491937c3bcbd10af:

  Linux 4.5-rc6 (2016-02-28 08:41:20 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-fixes

for you to fetch changes up to f3c87e99f401a0ff0ef941346ec6e790f0fd526e:

  Merge tag 'renesas-dt-fixes2-for-v4.5' of git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas into fixes (2016-03-02 23:24:33 +0100)

----------------------------------------------------------------
ARM: SoC fixes

Tiny fixes branch this week, in fact only one patch.

Turns out the USB support for a Renesas board was developed on a pre-release
board that ended up being changed before shipping. To avoid breakage on those
boards, and avoid confusion, it's a reasonable idea to patch now instead of
later. There are no known users of the pre-release variant any more.

----------------------------------------------------------------
Arnd Bergmann (1):
      Merge tag 'renesas-dt-fixes2-for-v4.5' of git://git.kernel.org/.../horms/renesas into fixes

Sergei Shtylyov (1):
      ARM: dts: porter: remove enable prop from HS-USB device node

 arch/arm/boot/dts/r8a7791-porter.dts | 1 -
 1 file changed, 1 deletion(-)
