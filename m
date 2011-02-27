From: eric.y.miao@gmail.com (Eric Miao)
Date: Sun, 27 Feb 2011 22:30:19 +0800
Subject: [GIT PULL] pxa: fixes for v2.6.38-rc6
Message-ID: <AANLkTinO7_ojbwV0t5Mc_osKuiZq6+BNk--t669c8S6Y@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit f5412be599602124d2bdd49947b231dd77c0bf99:

  Linux 2.6.38-rc6 (2011-02-21 17:25:52 -0800)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/ycmiao/pxa-linux-2.6.git fix

Dmitry Eremin-Solenikov (4):
      ARM: pxa/tosa: drop setting LED trigger name, as it's unsupported now
      ARM: pxa/colibri: don't register pxa2xx-pcmcia nodes on
non-colibri platforms
      ARM: pxa: enable pxa-pcm-audio on pxa210/pxa25x platform
      ARM: pxa/tosa: register wm9712 codec device

 arch/arm/mach-pxa/pxa25x.c      |    1 +
 arch/arm/mach-pxa/tosa-bt.c     |    2 --
 arch/arm/mach-pxa/tosa.c        |    6 ++++++
 drivers/pcmcia/pxa2xx_colibri.c |    3 +++
 4 files changed, 10 insertions(+), 2 deletions(-)
