From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Mon, 7 Mar 2016 15:29:55 +0100
Subject: [PATCH v2 0/2] iio: add support for signed conversions
Message-ID: <1457360997-29179-1-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jonathan,

I hope these patches are in adequacy with your comments. They are based on the
the previous two patches you have taken. I am not sure about the 
correctness of the documentation.

Ludovic Desroches (2):
  iio: core: introduce IIO_CHAN_INFO_SIGNED
  iio:adc:at91-sama5d2: add support for signed conversion

 Documentation/ABI/testing/sysfs-bus-iio |  10 +++
 drivers/iio/adc/at91-sama5d2_adc.c      | 125 ++++++++++++++++++++++++++------
 drivers/iio/industrialio-core.c         |   1 +
 include/linux/iio/iio.h                 |   1 +
 4 files changed, 114 insertions(+), 23 deletions(-)

-- 
2.5.0
