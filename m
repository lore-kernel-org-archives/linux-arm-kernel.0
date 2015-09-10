From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu, 10 Sep 2015 10:09:50 +0200
Subject: [PATCH 0/2] arm: efm32: dts updates
Message-ID: <1441872592-388-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

these two patches are part of my patch stack for efm32 since early in
2014. I intend to put them into next after 4.3-rc1 is released and let
them pull for 4.4-rc1 by the arm-soc folk. (Well unless someone objects of
course.)

Best regards
Uwe

Uwe Kleine-K?nig (2):
  ARM: efm32: switch to properly namespaced location property
  ARM: efm32: switch to vendor,device compatible strings

 arch/arm/boot/dts/efm32gg-dk3750.dts |  8 ++++----
 arch/arm/boot/dts/efm32gg.dtsi       | 32 ++++++++++++++++----------------
 2 files changed, 20 insertions(+), 20 deletions(-)

-- 
2.5.0
