From: 21cnbao@gmail.com (Barry Song)
Date: Sun, 11 Jan 2015 23:36:33 +0800
Subject: [GIT PULL] CSR new atlas7 machine,
 and delete old marco machine for 3.20
Message-ID: <CAGsJ_4w=TdNKJtDz8CJR4c8DntjZFh6zC3Pb+tyah9gRht+EqQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, Oolf,

The following changes since atlas7-lldebug-for-3.20(commit
e5bd2e9be6e5a8aecb79913f99a91f143f2b5191):

  ARM: sirf: add two debug ports for CSRatlas7 SoC (2015-01-11 22:53:34 +0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git

for you to fetch changes up to 63f72025f250a84fcef6a1683db796940e5ca1e3:

  ARM: sirf: add atlas7 machine support (2015-01-11 23:24:42 +0800)

----------------------------------------------------------------
drop CSR marco machine and add atlas7 new machine

this is the init support for CSR atlas7 new SoC. Old marco has been
dropped.

----------------------------------------------------------------
Barry Song (3):
      ARM: sirf: drop MARCO support in reset controller module
      ARM: sirf: drop MARCO machine
      ARM: sirf: move to debug_ll_io_init and drop map_io

Zhiwu Song (2):
      ARM: sirf: move platsmp to support atlas7 SoC
      ARM: sirf: add atlas7 machine support

 arch/arm/mach-prima2/Kconfig    |   22 +++++++++--------
 arch/arm/mach-prima2/common.c   |   22 ++++-------------
 arch/arm/mach-prima2/lluart.c   |   33 -------------------------
 arch/arm/mach-prima2/platsmp.c  |   52 ++++++++++-----------------------------
 arch/arm/mach-prima2/rstc.c     |   41 +++++++++---------------------
 arch/arm/mach-prima2/rtciobrg.c |    1 -
 6 files changed, 42 insertions(+), 129 deletions(-)
 delete mode 100644 arch/arm/mach-prima2/lluart.c

-barry
