From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Thu, 3 Mar 2016 17:09:12 +0100
Subject: [PATCH 0/3] iio:adc:at91-sama5d2: add support for signed conversion
Message-ID: <1457021355-23898-1-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This set of patches does some cleanup in the code and export channels for
signed and unsigned conversions.

Ludovic Desroches (3):
  iio:adc:at91-sama5d2: fix typo
  iio:adc:at91-sama5d2: fix identation
  iio:adc:at91-sama5d2: add support for signed conversion

 drivers/iio/adc/at91-sama5d2_adc.c | 101 ++++++++++++++++++++++++++++---------
 1 file changed, 77 insertions(+), 24 deletions(-)

-- 
2.5.0
