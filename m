From: narmstrong@baylibre.com (Neil Armstrong)
Date: Tue,  4 Oct 2016 15:41:45 +0200
Subject: [PATCH 0/3] pinctrl: oxnas: Add Support for OX820
Message-ID: <20161004134148.23028-1-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds support for the Oxford Semiconductor OX820 SoC Pinctrl
registers along he OX810 Pinctrl support.
The GPIO control registers are common enough to leave the code untouched.

Neil Armstrong (3):
  pinctrl: oxnas: Move OX810SE specific function and structure as
    separate
  pinctrl: oxnas: Add support for OX820
  dt-bindings: oxnas: Update Pinctrl and GPIO for OX820 Support

 .../devicetree/bindings/gpio/gpio_oxnas.txt        |   2 +-
 .../devicetree/bindings/pinctrl/oxnas,pinctrl.txt  |   2 +-
 drivers/pinctrl/pinctrl-oxnas.c                    | 605 ++++++++++++++++++---
 3 files changed, 534 insertions(+), 75 deletions(-)

-- 
2.7.0
