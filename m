From: wenyou.yang@microchip.com (Wenyou Yang)
Date: Fri, 1 Sep 2017 11:09:31 +0800
Subject: [PATCH 0/4] media: atmel-isc: Rework the format list and the clock
Message-ID: <20170901030935.29717-1-wenyou.yang@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To improve the readability of code, rework the format list table,
split the format array into two. And fix the clock operation issue.


Wenyou Yang (4):
  media: atmel_isc: Add spin lock for clock enable ops
  media: atmel-isc: Add prepare and unprepare ops
  media: atmel-isc: Enable the clocks during probe
  media: atmel-isc: Rework the format list

 drivers/media/platform/atmel/atmel-isc-regs.h |   1 +
 drivers/media/platform/atmel/atmel-isc.c      | 599 ++++++++++++++++++++------
 2 files changed, 474 insertions(+), 126 deletions(-)

-- 
2.13.0
