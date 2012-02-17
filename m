From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 17 Feb 2012 16:02:23 +0100
Subject: [GIT PULL] at91 mmc fixes for 3.3-rc[45]
Message-ID: <4F3E6BFF.9030307@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chris,

This is a couple of patches that fixes a sequence in atmel-mci during 
DMA/PDC detection + channel handling.

I also add the MAINTAINERS update and hand the SD/MMC drivers over to 
Ludovic Desroches who already made great efforts to enhance them.

You can find that the following changes since commit d65b4e98d7ea3038b767b70fe8be959b2913f16d:

  Linux 3.3-rc3 (2012-02-08 19:21:53 -0800)

are available in the git repository at:

  git://github.com/at91linux/linux-at91.git mmc-at91-fixes-for-3.3-rc4

for you to fetch changes up to 71055393e9e76a0c03f0b3b9d370a0ad2bae2763:

  MAINTAINERS: hand over atmel-mci (sd/mmc interface) (2012-02-17 15:40:18 +0100)

----------------------------------------------------------------
Ludovic Desroches (2):
      mmc: atmel-mci: don't use dma features when dma is present but there is no chan available
      mmc: atmel-mci: fix typo

Nicolas Ferre (1):
      MAINTAINERS: hand over atmel-mci (sd/mmc interface)

 MAINTAINERS                  |    4 ++--
 drivers/mmc/host/atmel-mci.c |   23 +++++++++++------------

Thanks a lot, best regards,
-- 
Nicolas Ferre
