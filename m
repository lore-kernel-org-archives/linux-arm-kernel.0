From: jochen@scram.de (Jochen Friedrich)
Date: Fri, 18 Feb 2011 11:02:45 +0100
Subject: [PATCH RESEND 2.6.39 0/3] ARM: simpad: Add support for GPIO attached
	hardware
Message-ID: <1298023368-27090-1-git-send-email-jochen@scram.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series enables GPIO API on UCB1x00 and implements the GPIO
API on the CS3 latch. The third patch finally registers platform
devices for the GPIO attached LED, buttons and I2C bus.

ARM: simpad: Add ucb1x00 GPIO definitions and register GPIO
ARM: simpad: Cleanup CS3 accessors and add GPIO API
ARM: simpad: add GPIO based device definitions
