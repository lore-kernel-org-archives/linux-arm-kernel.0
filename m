From: tony@atomide.com (Tony Lindgren)
Date: Tue, 27 May 2014 11:08:54 -0700
Subject: [PATCH v3 0/6] mfd: twl4030-power: Enable off-idle configuration when
 booted with device tree
Message-ID: <1401214140-9828-1-git-send-email-tony@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee,

Here are these patches for you again as you requested.
I left out the last patch in the series containing the
related .dts changes to enable these features as
that I can apply separately.

Regards,

Tony


Tony Lindgren (6):
  mfd: twl4030-power: Fix hang on reboot if sleep configuration was
    loaded earlier
  mfd: twl4030-power: Fix some defines for SW_EVENTS
  mfd: twl4030-power: Add generic reset configuration
  mfd: twl4030-power: Add recommended idle configuration
  mfd: twl4030-power: Add support for board specific configuration
  mfd: twl4030-power: Add a configuration to turn off oscillator during
    off-idle

 .../devicetree/bindings/mfd/twl4030-power.txt      |  17 +-
 drivers/mfd/twl4030-power.c                        | 286 +++++++++++++++++++--
 include/linux/i2c/twl.h                            |   4 +
 3 files changed, 281 insertions(+), 26 deletions(-)

-- 
1.8.1.1
