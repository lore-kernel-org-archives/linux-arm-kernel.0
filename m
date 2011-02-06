From: khc@pm.waw.pl (Krzysztof Halasa)
Date: Sun, 06 Feb 2011 20:09:35 +0100
Subject: [PULL REQ] IXP4xx: a couple of fixes
Message-ID: <m34o8hou8g.fsf@intrepid.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus,

the following changes since commit ebf53826e105f488f4f628703a108e98940d1dc5:

  Linux 2.6.38-rc3 (2011-02-01 13:05:49 +1000)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/chris/linux-2.6.git ixp4xx

Ben Hutchings (1):
      arm/ixp4xx: Rename FREQ macro to avoid collisions

Krzysztof Ha?asa (1):
      IXP4xx: Fix qmgr_release_queue() flushing unexpected queue entries.

Please pull. Thanks.

 arch/arm/mach-ixp4xx/common.c             |    4 ++--
 arch/arm/mach-ixp4xx/include/mach/timex.h |    5 +++--
 arch/arm/mach-ixp4xx/ixp4xx_qmgr.c        |    9 +++++----
 drivers/input/misc/ixp4xx-beeper.c        |    6 +-----
 4 files changed, 11 insertions(+), 13 deletions(-)
-- 
Krzysztof Halasa
