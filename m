From: ludovic.desroches@atmel.com (ludovic.desroches at atmel.com)
Date: Fri, 29 Mar 2013 15:54:10 +0100
Subject: [PATCH v2 0/3] iio: at91_adc: add lowres,
 sleep and sample&hold time missing support
Message-ID: <1364568853-18561-1-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ludovic Desroches <ludovic.desroches@atmel.com>

Hi,

The current adc driver is missing some key feature support
  - select high/low resolution support
  - sleep mode
  - sample and hold Time

v2 changes:
- split dts part
- correct typo and documentation


Jean-Christophe PLAGNIOL-VILLARD (2):
  iio: at91_adc: add sleep mode support
  iio: at91_adc: fix missing Sample and Hold time

Ludovic Desroches (1):
  iio: at91_adc: add low and high res support

 .../devicetree/bindings/arm/atmel-adc.txt          | 13 ++++
 drivers/iio/adc/at91_adc.c                         | 90 ++++++++++++++++++++--
 2 files changed, 98 insertions(+), 5 deletions(-)

-- 
1.7.11.3
