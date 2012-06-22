From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 22 Jun 2012 11:14:52 +0200
Subject: [PATCH v2] ARM:MXS: Initial support for the Crystalfontz CFA-10036
Message-ID: <1340356494-24664-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

This is the second version for the initial support for the
Crystalfontz CFA-10036 module.

The module basically has a iMX28 SoC, plus a micro-SD slot, 3 pins to
access the DUART, a USB OTG port, a OLED screen using the Solomon
SSD1307 controller over I2C and a 200-pins SODIMM port to plug an
expansion board.

Support for this board and the additional devices will come
eventually.

For now, only the DUART and the MMC controller are used.

What changed from v1:
  * MMC now works thanks to Shawn Guo
  * Removed the board file
  * Moved alternate muxing options for the imx28 to the DTSI

Thanks,
Maxime
