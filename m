From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 09 Oct 2015 18:05:17 +0200
Subject: [GIT PULL] ARM: mvebu: cleanup for v4.4
Message-ID: <87oag8rps2.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is the first pull request for cleanup for mvebu for v4.4.

Gregory

The following changes since commit 6ff33f3902c3b1c5d0db6b1e2c70b6d76fba357f:

  Linux 4.3-rc1 (2015-09-12 16:35:56 -0700)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-cleanup-4.4-1

for you to fetch changes up to 7ee20ff0072154d326c86223fbb88d23aa152b91:

  ARM: mvebu: Use a CR_C constant instead of a hard-coded one (2015-09-29 18:01:19 +0200)

----------------------------------------------------------------
mvebu cleanup for 4.4 (part 1)

use the CR_C define instead of a literal value

----------------------------------------------------------------
Gregory CLEMENT (1):
      ARM: mvebu: Use a CR_C constant instead of a hard-coded one

 arch/arm/mach-mvebu/pmsu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
