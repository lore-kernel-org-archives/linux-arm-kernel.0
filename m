From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 21 Feb 2014 17:03:30 -0500
Subject: [GIT PULL V2] irqchip: mvebu fixes for v3.14
In-Reply-To: <20140218162210.GU7862@titan.lakedaemon.net>
References: <20140218162210.GU7862@titan.lakedaemon.net>
Message-ID: <20140221220330.GN7862@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thomas,

Here it is.  Sorry for the delay.  I was under the weather past couple
days.

thx,

Jason.

The following changes since commit 38dbfb59d1175ef458d006556061adeaa8751b72:

  Linus 3.14-rc1 (2014-02-02 16:42:13 -0800)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/irqchip-mvebu-fixes-3.14

for you to fetch changes up to d86e9af6336c0ad586a5dbd70064253d40bbb5ff:

  irqchip: orion: Fix getting generic chip pointer. (2014-02-21 21:46:56 +0000)

----------------------------------------------------------------
irqchip mvebu fixes for v3.14

 - orion:
    - fixes for clearing bridge cause register, and clearing stale interrupts

----------------------------------------------------------------
Andrew Lunn (1):
      irqchip: orion: Fix getting generic chip pointer.

Sebastian Hesselbarth (3):
      irqchip: orion: clear bridge cause register on init
      irqchip: orion: use handle_edge_irq on bridge irqs
      irqchip: orion: clear stale interrupts in irq_startup

 drivers/irqchip/irq-orion.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)
