From: eric@anholt.net (Eric Anholt)
Date: Thu, 10 Sep 2015 15:22:27 -0700
Subject: BCM2835 auxiliary peripheral clocks.
Message-ID: <1441923750-19404-1-git-send-email-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a followup to the main audio domain clocks series I just
posted.  There's a clock gate register controlling the clocks for a
few extra peripherals, and Martin Sperl has been working on the SPI
driver for 2/3 of them (the other is a simple UART).  This gives those
drivers the clock gate enable they need to access their registers.

The full series is available for testing at:

https://github.com/anholt/linux/tree/bcm2385-clock-aux
