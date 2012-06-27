From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 27 Jun 2012 10:18:10 +0200
Subject: [PATCH v3] ARM:MXS: Initial support for the Crystalfontz CFA-10036
Message-ID: <1340785092-27035-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

This is the third version for the initial support for the
Crystalfontz CFA-10036 module.

The module basically has a iMX28 SoC, plus a micro-SD slot, 3 pins to
access the DUART, a USB OTG port, a OLED screen using the Solomon
SSD1307 controller over I2C and a 200-pins SODIMM port to plug an
expansion board.

Support for this board and the additional devices will come
eventually.

For now, only the DUART and the MMC controller are used.

What changed from v2:
  * Changed the pinctrl function names for the duart
  * Added the compatible string to the imx28_dt_compat structure 

Thanks,
Maxime
