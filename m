From: claudiu.beznea@microchip.com (Claudiu Beznea)
Date: Tue, 28 Feb 2017 12:40:13 +0200
Subject: [PATCH 0/2] switch to atomic PWM
Message-ID: <1488278415-2786-1-git-send-email-claudiu.beznea@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Switch atmel-pwm driver to atomic PWM and
enable it for sama5d2

Claudiu Beznea (2):
  drivers: pwm: pwm-atmel: switch to atomic PWM
  drivers: pwm: pwm-atmel: enable pwm on sama5d2

 .../devicetree/bindings/pwm/atmel-pwm.txt          |   1 +
 drivers/pwm/pwm-atmel.c                            | 220 +++++++++++----------
 2 files changed, 122 insertions(+), 99 deletions(-)

-- 
2.7.4
