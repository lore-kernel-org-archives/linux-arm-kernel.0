From: eric.y.miao@gmail.com (Eric Miao)
Date: Mon, 12 Oct 2009 15:51:39 +0800
Subject: [GIT PULL] pxa: fixes for 2.6.32-rc4
Message-ID: <f17812d70910120051i5425f07ese1ccbfa0d7f1115d@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

Please help pull the following 3 fixes:

The following changes since commit 161291396e76e0832c08f617eb9bd364d1648148:
  Linus Torvalds (1):
        Linux 2.6.32-rc4

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ycmiao/pxa-linux-2.6.git fix

Antonio Ospite (1):
      [ARM] pxamci: fix printing gpio numbers in pxamci_probe

Dennis O'Brien (1):
      [ARM] pxa: workaround errata #37 by not using half turbo switching

Julia Lawall (1):
      [ARM] pxa/csb726: adjust duplicate structure field initialization

 arch/arm/mach-pxa/cpufreq-pxa2xx.c |    2 +-
 arch/arm/mach-pxa/csb726.c         |    2 +-
 drivers/mmc/host/pxamci.c          |    4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)
