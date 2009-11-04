From: eric.y.miao@gmail.com (Eric Miao)
Date: Wed, 4 Nov 2009 23:30:04 +0800
Subject: [GIT PULL] pxa: fixes for 2.6.32-rc5
Message-ID: <f17812d70911040730y38fb769dr1dae9038974c941b@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

The following changes since commit b6727b12dd2ffb4a890eb5b13a298230c29ba45d:
  Linus Torvalds (1):
        Merge git://git.kernel.org/.../gregkh/staging-2.6

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ycmiao/pxa-linux-2.6.git fix

Haojian Zhuang (1):
      [ARM] pxa: fix resume failure by saving/restoring IPRx registers

Ondrej Zajicek (1):
      [ARM] pxa/palm: fix incorrect initialization of Palm Tungsten C keyboard

Stanislav Brabec (1):
      [ARM] pxa/zaurus: fix NAND flash OOB layout for Borzoi

 arch/arm/mach-pxa/irq.c    |   11 ++++++++++-
 arch/arm/mach-pxa/palmtc.c |    8 ++++----
 arch/arm/mach-pxa/spitz.c  |   39 +++++++++++++++++++++++----------------
 3 files changed, 37 insertions(+), 21 deletions(-)
