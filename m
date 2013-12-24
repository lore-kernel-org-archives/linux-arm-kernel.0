From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 24 Dec 2013 15:05:35 +0900
Subject: [GIT PULL 0/3] Renesas ARM based SoC IRQC Driver Updates for v3.14
Message-ID: <cover.1387855444.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin, Hi Olof, Hi Arnd,

please consider these Renesas ARM based SoC IRQC driver updates for v3.14.

The following changes since commit 6ce4eac1f600b34f2f7f58f9cd8f0503d79e42ae:

  Linux 3.13-rc1 (2013-11-22 11:30:55 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-irqc-for-v3.14

for you to fetch changes up to ce70af18801fd8dac6e9f85308294948916e84d6:

  irq-renesas-irqc: simplify irq_set_type() method (2013-12-23 09:27:17 +0900)

----------------------------------------------------------------
Renesas ARM based SoC IRQC Driver Updates for v3.14

* Simplify irq_set_type() method
* Enable mask on suspend
* Use lazy disable

----------------------------------------------------------------
Magnus Damm (2):
      irqchip: renesas-irqc: Use lazy disable
      irqchip: renesas-irqc: Enable mask on suspend

Sergei Shtylyov (1):
      irq-renesas-irqc: simplify irq_set_type() method

 drivers/irqchip/irq-renesas-irqc.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)
