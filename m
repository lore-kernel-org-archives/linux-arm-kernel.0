From: eric.y.miao@gmail.com (Eric Miao)
Date: Wed, 9 Feb 2011 23:22:30 +0800
Subject: [GIT PULL] pxa: fixes for v2.6.38-rc4
Message-ID: <AANLkTinNTEGikc87pwKMgEzQvoFyR3kgpU0aihKw3py=@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 100b33c8bd8a3235fd0b7948338d6cbb3db3c63d:

  Linux 2.6.38-rc4 (2011-02-07 16:03:55 -0800)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/ycmiao/pxa-linux-2.6.git fix

Bj?rn Forsman (1):
      ARM: pxa/colibri: use correct SD detect pin

Eric Miao (1):
      ARM: pxa: only save/restore registers when pm functions are defined

Marek Vasut (1):
      ARM: pxa: Properly configure PWM period for palm27x

Yu Tang (1):
      ARM: pxa: fix mfpr_sync to read from valid offset

 arch/arm/mach-pxa/colibri-evalboard.c    |    2 +-
 arch/arm/mach-pxa/colibri-pxa300.c       |    2 +-
 arch/arm/mach-pxa/include/mach/colibri.h |    2 +-
 arch/arm/mach-pxa/palm27x.c              |    2 +-
 arch/arm/mach-pxa/pm.c                   |    4 ++--
 arch/arm/plat-pxa/mfp.c                  |    8 ++++++--
 6 files changed, 12 insertions(+), 8 deletions(-)
