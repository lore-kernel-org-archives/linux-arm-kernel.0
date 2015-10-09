From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 09 Oct 2015 17:59:41 +0200
Subject: [GIT PULL] ARM: mvebu: fixes for v4.3
Message-ID: <87si5krq1e.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the first pull request for fixes for mvebu for v4.3.

Gregory

The following changes since commit 6ff33f3902c3b1c5d0db6b1e2c70b6d76fba357f:

  Linux 4.3-rc1 (2015-09-12 16:35:56 -0700)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-fixes-4.3-1

for you to fetch changes up to d836ace65ee98d7079bc3c5afdbcc0e27dca20a3:

  ARM: orion: Fix DSA platform device after mvmdio conversion (2015-10-06 16:22:37 +0200)

----------------------------------------------------------------
mvebu fixes for 4.3 (part 1)

DSA fixes for orion platform

----------------------------------------------------------------
Florian Fainelli (1):
      ARM: orion: Fix DSA platform device after mvmdio conversion

 arch/arm/plat-orion/common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
