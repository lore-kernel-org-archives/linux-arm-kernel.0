From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Fri,  9 Oct 2015 20:47:26 +0200
Subject: [GIT PULL] ARM: berlin: Fixes for v4.3 (round 1)
Message-ID: <1444416446-3004-1-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Kevin, Olof,

this is mach-berlin fixes for v4.3 with a patch to fix a wrong usb phy
compatible on BG2Q that I have missed to pick up last cycle.
The patch is, like the others from that patch set, tagged for -stable.

Please pull.

Sebastian

The following changes since commit 6ff33f3902c3b1c5d0db6b1e2c70b6d76fba357f:

  Linux 4.3-rc1 (2015-09-12 16:35:56 -0700)

are available in the git repository at:

  git://git.infradead.org/users/hesselba/linux-berlin.git tags/berlin-fixes-for-4.3-1

for you to fetch changes up to 1f744fd317dc55cadd7132c57c499e3117aea01d:

  ARM: dts: berlin: change BG2Q's USB PHY compatible (2015-10-01 21:07:15 +0200)

----------------------------------------------------------------
Marvell Berlin fixes for v4.3 take 1
- BG2Q USB PHY compatible fix (also tagged for stable v4.2)

----------------------------------------------------------------
Thomas Hebb (1):
      ARM: dts: berlin: change BG2Q's USB PHY compatible

 arch/arm/boot/dts/berlin2q.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)
