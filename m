From: jochen@scram.de (Jochen Friedrich)
Date: Thu, 21 Apr 2011 11:18:59 +0200
Subject: [PATCHv3 2.6.40 0/4] ARM: simpad: Add support for GPIO attached
	hardware
Message-ID: <1303377543-24794-1-git-send-email-jochen@scram.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series enables GPIO API on UCB1x00 and implements the GPIO
API on the CS3 latch. The third patch finally registers platform
devices for the GPIO attached LED, buttons and I2C bus.

v2: In response to the Linus rant, remove the ARM specific LED
    support for simpad hardware instead of supporting it
    alternatively to the generic LED code.

v3: Move LED changes into a seperate patch.

ARM: simpad: Add ucb1x00 GPIO definitions and register GPIO
ARM: simpad: Cleanup CS3 accessors and add GPIO API
ARM: simpad: add GPIO based device definitions
ARM: simpad: replace ARM specific LED code
