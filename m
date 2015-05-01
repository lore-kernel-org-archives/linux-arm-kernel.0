From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 01 May 2015 19:20:00 +0200
Subject: [GIT PULL] ARM: mvebu: fixes for v4.1
Message-ID: <5543B5C0.4080200@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the first pull request for fixes for mvebu for v4.1. There
are more which will come later but which have not been yet in linux-next.

Gregory

The following changes since commit b787f68c36d49bb1d9236f403813641efa74a031:

  Linux 4.1-rc1 (2015-04-26 17:59:10 -0700)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-fixes-4.1

for you to fetch changes up to 750e30d4076ae5e02ad13a376e96c95a2627742c:

  ARM: mvebu: armada-xp-openblocks-ax3-4: Disable internal RTC (2015-04-27 09:27:18 +0200)

----------------------------------------------------------------
mvebu fix for 4.1

Disable the unused internal RTC in the dts of the OpenBlock AX3

----------------------------------------------------------------
Gregory CLEMENT (1):
      ARM: mvebu: armada-xp-openblocks-ax3-4: Disable internal RTC

 arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts | 4 ++++
 1 file changed, 4 insertions(+)
-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
