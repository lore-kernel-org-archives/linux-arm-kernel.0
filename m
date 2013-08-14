From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 14 Aug 2013 15:28:10 -0400
Subject: [GIT PULL] ARM: mvebu: soc changes for v3.12
Message-ID: <20130814192810.GF13964@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof,


The following changes since commit ad81f0545ef01ea651886dddac4bef6cec930092:

  Linux 3.11-rc1 (2013-07-14 15:18:27 -0700)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/soc-3.12

for you to fetch changes up to a7160b7eaf2d914e1b552807b9d13acf23b47293:

  ARM: mach-mvebu: remove redundant DT parsing and validation (2013-08-09 13:02:51 +0000)

----------------------------------------------------------------
mvebu soc changes for v3.12

 - mvebu
    - cleanup redundant code

----------------------------------------------------------------
Sudeep KarkadaNagesha (1):
      ARM: mach-mvebu: remove redundant DT parsing and validation

 arch/arm/mach-mvebu/platsmp.c | 19 +------------------
 1 file changed, 1 insertion(+), 18 deletions(-)
