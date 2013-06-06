From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  6 Jun 2013 16:28:46 +0900
Subject: [GIT PULL v2 0/2] Update for Renesas INTC External IRQ pin driver for
 v3.11
Message-ID: <1370503728-31373-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Arnd,

The following changes since commit c7788792a5e7b0d5d7f96d0766b4cb6112d47d75:

  Linux 3.10-rc2 (2013-05-20 14:37:38 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-intc-external-irq-for-v3.11

for you to fetch changes up to 0d7c1210992ff05ee8de5d2c790defded3856f29:

  irqchip: Add irqchip_init dummy function (2013-06-06 10:23:58 +0900)

----------------------------------------------------------------
Update for Renesas INTC External IRQ pin driver for v3.11

Correct error handing in irqc_probe
Add irqchip_init dummy function

----------------------------------------------------------------
Axel Lin (1):
      irqchip: renesas-irqc: Fix irqc_probe error handling

Bastian Hecht (1):
      irqchip: Add irqchip_init dummy function

 drivers/irqchip/irq-renesas-irqc.c | 4 ++--
 include/linux/irqchip.h            | 4 ++++
 2 files changed, 6 insertions(+), 2 deletions(-)
