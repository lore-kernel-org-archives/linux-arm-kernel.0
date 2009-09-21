From: khc@pm.waw.pl (Krzysztof Halasa)
Date: Mon, 21 Sep 2009 20:18:26 +0200
Subject: [PULL REQ] IXP4xx
Message-ID: <m3eiq0duvh.fsf@intrepid.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus,

Please pull from my IXP4xx tree. This is rather trivial, and based on
your current HEAD to eliminate a conflict. Thanks.

The following changes since commit 43c1266ce4dc06bfd236cec31e11e9ecd69c0bef:
  Linus Torvalds (1):
        Merge branch 'perfcounters-rename-for-linus' of git://git.kernel.org/.../tip/linux-2.6-tip

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chris/linux-2.6.git ixp4xx

Krzysztof Ha?asa (1):
      Add MAINTAINERS entry for ARM/INTEL IXP4xx arch support.

Mikael Pettersson (2):
      ixp4xx: timer and clocks cleanups
      ixp4xx: arch_idle() documentation fixup

 MAINTAINERS                                |    7 +++++++
 arch/arm/mach-ixp4xx/common.c              |   16 +++++++---------
 arch/arm/mach-ixp4xx/include/mach/system.h |    6 ++++--
 3 files changed, 18 insertions(+), 11 deletions(-)

-- 
Krzysztof Halasa
