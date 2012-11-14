From: alban.bedel@avionic-design.de (Alban Bedel)
Date: Wed, 14 Nov 2012 13:59:43 +0100
Subject: [PATCH V2 0/2] pwm: lpc32xx - Add a driver for the motor PWM
Message-ID: <1352897985-15419-1-git-send-email-alban.bedel@avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a new submission of the LPC32xx Motor PWM driver with the
following changes:

* Splitted the arch part in a separate patch
* Removed the useless clock ref counting
* Fixed remove() to properly disable the clock

[PATCH 1/2] pwm: lpc32xx - Add a driver for the motor PWM
[PATCH 2/2] ARM: LPC32xx: Add the motor PWM to base dts file

Alban
