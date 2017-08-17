From: wenyou.yang@microchip.com (Wenyou Yang)
Date: Thu, 17 Aug 2017 15:16:11 +0800
Subject: [PATCH 0/3] media: atmel-isc: Supplement the configuration of formats
Message-ID: <20170817071614.12767-1-wenyou.yang@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The intention of the patch set is to add more configuration of
formats: GREY, ARGB444, ARGB555 and ARGB32, and add the checking
the format from the extern sensor which doesn't support RGB
formats from the external sensor.


Wenyou Yang (3):
  media: atmel-isc: Not support RBG format from sensor.
  media: atmel-isc: Remove the redundant assignment
  media: atmel-isc: Add more format configurations

 drivers/media/platform/atmel/atmel-isc.c | 89 ++++++++++++++++++++------------
 1 file changed, 56 insertions(+), 33 deletions(-)

-- 
2.13.0
