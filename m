From: eric.miao@linaro.org (Eric Miao)
Date: Mon, 11 Jul 2011 15:25:30 +0800
Subject: [GIT PULL] pxa: fixes for v3.0-rc6 (2nd bunch)
Message-ID: <CAMPhdO_NxvJmZqK23USQ3HVn2eXhuNpvM=EeWq3nwpt3WOUbzw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 6662498e132dfa758925a160fd5ef80a083651c3:

  ARM: pxa168: correct nand pmu setting (2011-07-06 23:51:36 +0800)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/ycmiao/pxa-linux-2.6.git fix

Daniel Mack (1):
      ARM: pxa/raumfeld: fix device name for codec ak4104

Jonathan Cameron (1):
      pcmcia: pxa2xx/vpac270: free gpios on exist rather than requesting

Linus Walleij (1):
      ARM: pxa: fix gpio_to_chip() clash with gpiolib namespace

Sven Neumann (2):
      ARM: pxa/raumfeld: adapt to upcoming hardware change
      ARM: pxa/raumfeld: display initialisation fixes

 arch/arm/mach-pxa/raumfeld.c    |   36 +++++++++++++++++++-----------------
 arch/arm/plat-pxa/gpio.c        |   10 +++++-----
 drivers/pcmcia/pxa2xx_vpac270.c |    4 ++--
 3 files changed, 26 insertions(+), 24 deletions(-)
