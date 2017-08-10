From: wenyou.yang@microchip.com (Wenyou Yang)
Date: Thu, 10 Aug 2017 17:06:43 +0800
Subject: [PATCH 0/2] media: ov7670: Add entity init and power operation
Message-ID: <20170810090645.24344-1-wenyou.yang@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set is to add the media entity pads initialization and add
the s_power operation.


Wenyou Yang (2):
  media: ov7670: Add entity pads initialization
  media: ov7670: Add the s_power operation

 drivers/media/i2c/ov7670.c | 43 +++++++++++++++++++++++++++++++++++++++----
 1 file changed, 39 insertions(+), 4 deletions(-)

-- 
2.13.0
