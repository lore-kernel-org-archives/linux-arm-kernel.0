From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 29 Mar 2013 15:56:46 +0900
Subject: [GIT PULL] Update for Renesas INTC External IRQ pin driver for v3.10
Message-ID: <1364540207-7699-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Hi Olof,

The following changes since commit 3b8dfa7c2f8af7613dae28ac0f3419bf75ead5d0:

  irqchip: irqc: Add DT support (2013-03-18 21:26:07 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-intc-external-irq2-for-v3.10

for you to fetch changes up to 427cc720277c140e6a63a03237f9bf37d8076ac3:

  irqchip: intc-irqpin: Add support for shared interrupt lines (2013-03-28 16:39:46 +0900)

----------------------------------------------------------------
Update for Renesas INTC External IRQ pin driver for v3.10

This adds support for shared interrupt lines to the
Renesas INTC External IRQ pin driver which has already
been queued up for v3.10 (tag renesas-intc-external-irq-for-v3.10).

----------------------------------------------------------------
Bastian Hecht (1):
      irqchip: intc-irqpin: Add support for shared interrupt lines

 drivers/irqchip/irq-renesas-intc-irqpin.c |   90 ++++++++++++++++++++++++++---
 1 file changed, 83 insertions(+), 7 deletions(-)
