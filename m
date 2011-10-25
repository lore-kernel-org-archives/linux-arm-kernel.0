From: eric.y.miao@gmail.com (Eric Miao)
Date: Tue, 25 Oct 2011 21:05:33 +0800
Subject: [GIT PULL] pxa: feature patches for next
Message-ID: <CAMPhdO8A3OgzdKB_1t5ddY_JBtGvPUjphYYBs7zob0ik9he=Lw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit c3b92c8787367a8bb53d57d9789b558f1295cc96:

  Linux 3.1 (2011-10-24 09:10:05 +0200)

are available in the git repository at:
  git://github.com/ycmiao/pxa-linux.git feature

Leo Yan (3):
      ARM: mmp: add sram allocator
      ARM: mmp: register audio sram bank
      ARM: mmp: register internal sram bank

 arch/arm/Kconfig                      |    1 +
 arch/arm/mach-mmp/Makefile            |    2 +-
 arch/arm/mach-mmp/brownstone.c        |   11 ++
 arch/arm/mach-mmp/include/mach/mmp2.h |   13 +++
 arch/arm/mach-mmp/include/mach/sram.h |   35 +++++++
 arch/arm/mach-mmp/mmp2.c              |    3 +
 arch/arm/mach-mmp/sram.c              |  168 +++++++++++++++++++++++++++++++++
 7 files changed, 232 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-mmp/include/mach/sram.h
 create mode 100644 arch/arm/mach-mmp/sram.c
