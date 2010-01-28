From: eric.y.miao@gmail.com (Eric Miao)
Date: Thu, 28 Jan 2010 21:30:53 +0800
Subject: [GIT PULL] pxa: fixes for v2.6.33-rc4
Message-ID: <f17812d71001280530x1186b7k4b94b3cbedde53ba@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 7284ce6c9f6153d1777df5f310c959724d1bd446:
  Linus Torvalds (1):
        Linux 2.6.33-rc4

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ycmiao/pxa-linux-2.6.git fix

Eric Miao (3):
      [ARM] pxa/corgi: fix incorrect default GPIO for UDC Vbus
      [ARM] pxa: fix the incorrect naming of AC97 reset pin config for pxa26x
      [ARM] pxa: fix irq suspend/resume for pxa25x

 arch/arm/mach-pxa/corgi.c                   |    1 +
 arch/arm/mach-pxa/include/mach/mfp-pxa25x.h |    6 ++++--
 arch/arm/mach-pxa/irq.c                     |   14 ++++++++++----
 3 files changed, 15 insertions(+), 6 deletions(-)
