From: eric.y.miao@gmail.com (Eric Miao)
Date: Wed, 6 Jul 2011 00:11:29 +0800
Subject: [GIT PULL] pxa: fixing patches for v3.0-rc6
Message-ID: <CAMPhdO_6CqVn_SdX-tPBtmHjkKH6kiWzuRkCDWkxaCUacReQhg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit fe0d42203cb5616eeff68b14576a0f7e2dd56625:

  Linux 3.0-rc6 (2011-07-04 15:56:24 -0700)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/ycmiao/pxa-linux-2.6.git fix

Lei Wen (2):
      ARM: pxa910: correct nand pmu setting
      ARM: pxa168: correct nand pmu setting

Paul Parsons (1):
      ARM: pxa: fix PGSR register address calculation

 arch/arm/mach-mmp/pxa168.c     |    2 +-
 arch/arm/mach-mmp/pxa910.c     |    2 +-
 arch/arm/mach-pxa/mfp-pxa2xx.c |    4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)
