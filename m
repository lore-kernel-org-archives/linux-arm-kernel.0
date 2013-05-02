From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Thu, 2 May 2013 19:23:21 +0800
Subject: [PATCH] BUG: fix atmel spi doesn' support 16 bits transfers using PIO
Message-ID: <1367493801-3037-1-git-send-email-wenyou.yang@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

This patch is one of atmel spi add dmaengine support patch series which has some issue when applying:
	spi/spi-atmel: BUG: fix doesn' support 16 bits transfers using PIO

I regenerate it based on your next git tree.

Thanks a lot.

Best Regards
Wenyou Yang

Richard Genoud (1):
  spi/spi-atmel: BUG: fix doesn' support 16 bits transfers using PIO

 drivers/spi/spi-atmel.c |   47 ++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 38 insertions(+), 9 deletions(-)

-- 
1.7.9.5
