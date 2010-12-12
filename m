From: eric.y.miao@gmail.com (Eric Miao)
Date: Sun, 12 Dec 2010 23:42:48 +0800
Subject: [GIT PULL] pxa: fixes for v2.6.37-rc4
Message-ID: <AANLkTikTKAFNfJUgNG3AwFj-1risT53TeW348c-H5-y2@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit e8a7e48bb248a1196484d3f8afa53bded2b24e71:

  Linux 2.6.37-rc4 (2010-11-29 20:42:04 -0800)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/ycmiao/pxa-linux-2.6.git fix

Jason Chagas (1):
      ARM: mmp2: remove not used clk_rtc

Marek Vasut (2):
      ARM: pxa: fix pxa2xx-flash section mismatch
      ARM: pxa/palm: fix ifdef around gen_nand driver registration

 arch/arm/mach-mmp/mmp2.c        |    1 -
 arch/arm/mach-pxa/palmtx.c      |    3 ++-
 drivers/mtd/maps/pxa2xx-flash.c |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)
