From: ludovic.desroches@atmel.com (ludovic.desroches at atmel.com)
Date: Mon, 13 Aug 2012 17:38:53 +0200
Subject: [PATCH 0/1] ARM: at91: fix drivers broken because of sparse irq
 support
Message-ID: <1344872334-1532-1-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ludovic Desroches <ludovic.desroches@atmel.com>

Hello,

This patch fixes the rm9200 breakage (introduced by sparse irq support) reported
by Joachim Eastwood.

Regards

Ludovic

Ludovic Desroches (1):
  ARM: at91: fix drivers broken because of sparse irq support

 arch/arm/mach-at91/at91rm9200_time.c |  2 +-
 drivers/rtc/rtc-at91sam9.c           | 11 ++++++-----
 2 files changed, 7 insertions(+), 6 deletions(-)

-- 
1.7.11.3
