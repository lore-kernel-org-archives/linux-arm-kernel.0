From: Claudiu.Beznea@microchip.com (Claudiu.Beznea at microchip.com)
Date: Mon, 5 Nov 2018 11:14:21 +0000
Subject: [PATCH 0/4] power: reset: at91-poweroff: cleanups
Message-ID: <1541416443-4321-1-git-send-email-claudiu.beznea@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This series includes cleanups for at91-poweroff.c similar to the one did for
SAMA5D2 Xplained SHDWC on series at [1].

Changes were tested on SAMA5D3 Xplained, SAMA5D4 Xplained and AT91SAM9G35-EK
boards.

Thank you,
Claudiu Beznea

[1] https://www.spinics.net/lists/arm-kernel/msg673559.html

Claudiu Beznea (4):
  power: reset: at91-poweroff: use one poweroff function for
    at91-poweroff
  power: reset: at91-poweroff: move shdwc related data to one structure
  power: reset: at91-poweroff: check shdwc data structure at the
    beginning of probe
  power: reset: at91-poweroff: remove at91_ramc_of_match

 drivers/power/reset/at91-poweroff.c | 101 +++++++++++++++++++++---------------
 1 file changed, 59 insertions(+), 42 deletions(-)

-- 
2.7.4
