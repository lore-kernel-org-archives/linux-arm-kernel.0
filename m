From: simon.guinot@sequanux.org (Simon Guinot)
Date: Tue, 19 Mar 2013 19:07:28 +0100
Subject: [PATCH 0/4] led: drivers bug fixes
Message-ID: <1363716452-18870-1-git-send-email-simon.guinot@sequanux.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here are some bug fixes for the LED drivers leds-ns2, leds-lt3593 and
leds-renesas-tpu. Note that I don't have tested the patches related with
the two lasts. I don't have the hardware.

Regards,

Simon

Simon Guinot (4):
  leds: leds-ns2: fix oops at module removal
  leds: leds-ns2: fix devm_gpio_request_one() flags parameter
  leds: leds-lt3593: fix devm_gpio_request_one() flags parameter
  leds: renesas: fix devm_gpio_request_one() flags parameter

 drivers/leds/leds-lt3593.c      |    5 +++--
 drivers/leds/leds-ns2.c         |   44 ++++++++++++++++++++++++++-------------
 drivers/leds/leds-renesas-tpu.c |    3 ++-
 3 files changed, 34 insertions(+), 18 deletions(-)

-- 
1.7.10.4
