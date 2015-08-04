From: eddie.huang@mediatek.com (Eddie Huang)
Date: Tue, 4 Aug 2015 19:44:51 +0800
Subject: [PATCH 0/2] Mediatek I2C fixup  
Message-ID: <1438688693-60275-1-git-send-email-eddie.huang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series provide two patches to optimize mediatek i2c driver.
The first patch will reset dma hardware in init function to make sure
hardware work in good state. The second patch fix i2c interrupt handling
for ACK error. All these patches base on v4.2-rc1.

Eddie Huang (2):
  i2c: mediatek: Reset DMA engine in hardware init function
  i2c: mediatek: Fixup i2c ack error interrupt handling

 drivers/i2c/busses/i2c-mt65xx.c |   28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

-- 
1.7.9.5
