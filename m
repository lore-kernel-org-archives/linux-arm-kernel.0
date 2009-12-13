From: eric.y.miao@gmail.com (Eric Miao)
Date: Sun, 13 Dec 2009 21:09:02 +0800
Subject: [PATCH 0/2] pcmcia: two fixes for the pxa pcmcia code
Message-ID: <f17812d70912130509i37414557o71a33a66ed047f8e@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The two patches below fix the build issue for the pxa part of pcmcia:

Eric Miao (2):
      pcmcia: export pxa2xx_drv_pcmcia_{add_one, ops} to other modules
      pcmcia: fix now incorrect reference of skt->irq by using
skt->socket.pci_irq

 drivers/pcmcia/pxa2xx_base.c      |    2 ++
 drivers/pcmcia/pxa2xx_palmtc.c    |    2 +-
 drivers/pcmcia/pxa2xx_stargate2.c |    2 +-
 3 files changed, 4 insertions(+), 2 deletions(-)

I will basically push this to Russell together with some other pxa patches.
