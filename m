From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 16 Oct 2015 19:36:31 +0200
Subject: [GIT PULL] ARM: mvebu: fixes for v4.3
Message-ID: <874mhqhg0w.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the second pull request for fixes for mvebu for v4.3.

Gregory

The following changes since commit d836ace65ee98d7079bc3c5afdbcc0e27dca20a3:

  ARM: orion: Fix DSA platform device after mvmdio conversion (2015-10-06 16:22:37 +0200)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-fixes-4.3-2

for you to fetch changes up to db347f1a5304d68c68c52f19971924b1e5842f3c:

  ARM: mvebu: correct a385-db-ap compatible string (2015-10-15 08:25:09 +0200)

----------------------------------------------------------------
mvebu fixes for 4.3 (part 2)

Fix wrong compatible for A385 DB AP preventing using suspend

----------------------------------------------------------------
Marcin Wojtas (1):
      ARM: mvebu: correct a385-db-ap compatible string

 arch/arm/boot/dts/armada-385-db-ap.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
