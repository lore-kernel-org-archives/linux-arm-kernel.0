From: benjamin.zores@alcatel-lucent.com (Benjamin Zores)
Date: Thu, 17 Jun 2010 09:58:52 +0200
Subject: [PATCH 0/4] Series short description
Message-ID: <20100617075711.15387.69398.stgit@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following series implements support for Marvell 88F6282 SoC.
It should take into account all previously made comments.

---

Benjamin Zores (4):
      arch/arm/mach-kirkwood: update MPP definition.
      arch/arm/mach-kirkwood: add support for 88F6282-A0 revision
      arch/arm/mach-kirkwood: add support for 2nd PCIe port on 88f6282.
      arch/arm/mach-kirkwood: add support for 2nd TWSI controller on 88f6282.


 arch/arm/mach-kirkwood/addr-map.c                 |   21 +
 arch/arm/mach-kirkwood/common.c                   |   90 +++
 arch/arm/mach-kirkwood/common.h                   |   10 
 arch/arm/mach-kirkwood/db88f6281-bp-setup.c       |    2 
 arch/arm/mach-kirkwood/include/mach/bridge-regs.h |    3 
 arch/arm/mach-kirkwood/include/mach/irqs.h        |    4 
 arch/arm/mach-kirkwood/include/mach/kirkwood.h    |   43 +-
 arch/arm/mach-kirkwood/mpp.c                      |    2 
 arch/arm/mach-kirkwood/mpp.h                      |  595 +++++++++++----------
 arch/arm/mach-kirkwood/mv88f6281gtw_ge-setup.c    |    2 
 arch/arm/mach-kirkwood/netspace_v2-setup.c        |    6 
 arch/arm/mach-kirkwood/netxbig_v2-setup.c         |   34 +
 arch/arm/mach-kirkwood/openrd-setup.c             |    4 
 arch/arm/mach-kirkwood/pcie.c                     |  204 +++++--
 arch/arm/mach-kirkwood/rd88f6192-nas-setup.c      |    2 
 arch/arm/mach-kirkwood/rd88f6281-setup.c          |    2 
 arch/arm/mach-kirkwood/ts219-setup.c              |    8 
 arch/arm/mach-kirkwood/ts41x-setup.c              |   32 +
 18 files changed, 663 insertions(+), 401 deletions(-)

-- 
Signature
