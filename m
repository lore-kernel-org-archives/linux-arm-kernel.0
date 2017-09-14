From: wenyou.yang@microchip.com (Wenyou Yang)
Date: Thu, 14 Sep 2017 13:11:08 +0800
Subject: [PATCH v2 0/3] media: ov7670: Add entity init and power operation
Message-ID: <20170914051111.18197-1-wenyou.yang@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set is to add the media entity pads initialization,
the s_power operation and get_fmt callback support.

Changes in v2:
 - Add the patch to support the get_fmt ops.
 - Remove the redundant invoking ov7670_init_gpio().

Wenyou Yang (3):
  media: ov7670: Add entity pads initialization
  media: ov7670: Add the get_fmt callback
  media: ov7670: Add the s_power operation

 drivers/media/i2c/ov7670.c | 71 ++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 65 insertions(+), 6 deletions(-)

-- 
2.13.0
