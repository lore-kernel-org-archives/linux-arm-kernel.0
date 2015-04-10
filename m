From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 10 Apr 2015 08:51:43 +0200
Subject: [GIT PULL] ARM: mvebu: fixes changes for v4.0
Message-ID: <552772FF.3080807@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the second pull request for fixes for mvebu for v4.0.
Actually it is not a critical one, so it's fine applying it only
on v4.1 if you are not comfortable to send for v4.0

Gregory

The following changes since commit 548ae94c1cc7fc120848757249b9a542b1080ffb:

  ARM: mvebu: Disable CPU Idle on Armada 38x (2015-03-31 18:47:33 +0200)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-fixes-4.0-2

for you to fetch changes up to 4f054d445139d63868f931328f897ac5ef87242e:

  ARM: mvebu: use 0xf1000000 as internal registers on Armada 370 DB (2015-04-08 16:37:02 +0200)

----------------------------------------------------------------
mvebu fix for 4.0

use 0xf1000000 as internal registers on Armada 370 DB: needed for the
recent version of the board which no more comes with a bogus version of
the Armada 370 SoC.

----------------------------------------------------------------
Thomas Petazzoni (1):
      ARM: mvebu: use 0xf1000000 as internal registers on Armada 370 DB

 arch/arm/boot/dts/armada-370-db.dts | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)
-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
