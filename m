From: jason@lakedaemon.net (Jason Cooper)
Date: Sun, 30 Sep 2012 21:25:21 -0400
Subject: [GIT PULL] ARM: mvebu: gpio fix for v3.7
Message-ID: <20121001012521.GI17765@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof,

Depends:
 - Based on arm-soc/late/kirkwood

Adds:
 - missing break;s from converting if{}s to switch{}

The following changes since commit 46f2007c1efadfa4071c17e75f140c47f09293de:

  ARM: mvebu: fix build breaks from multi-platform conversion (2012-09-28 22:27:07 +0200)

are available in the git repository at:
  git://git.infradead.org/users/jcooper/linux.git mvebu/gpio-fixes

Axel Lin (1):
      gpio: mvebu: Add missing breaks in mvebu_gpio_irq_set_type

 drivers/gpio/gpio-mvebu.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)
