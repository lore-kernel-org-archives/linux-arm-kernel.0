From: shubhrajyoti@ti.com (Shubhrajyoti D)
Date: Fri, 13 Jan 2012 12:27:04 +0530
Subject: [PATCHv9 0/2] I2C driver updates
Message-ID: <1326437826-7408-1-git-send-email-shubhrajyoti@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch series does the following 

- Removes the reset from probe and inplements a seperate 
  function.
- Removes the reset from init as hwmod does it.
- The second patch inplements the recovery from bus busy condition

Tested on omap4sdp and omap3430

applies to Kevin's  for_3.3/i2c/misc

Shubhrajyoti D (1):
  OMAP : I2C : Remove reset at init

Vikram Pandita (1):
  I2C: OMAP: Recover from bus busy condition

 drivers/i2c/busses/i2c-omap.c |   53 +++++++++++++++++++++++++++++++++-------
 1 files changed, 43 insertions(+), 10 deletions(-)
