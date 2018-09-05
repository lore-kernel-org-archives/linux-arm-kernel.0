From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Wed, 5 Sep 2018 21:59:23 +0200 (CEST)
Subject: [PATCH] ARM: dts: bcm283x-rpi-lan7515: Enable Ethernet LEDs
In-Reply-To: <1535830181-17254-1-git-send-email-stefan.wahren@i2se.com>
References: <1535830181-17254-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <1967640359.21557.1536177563791@email.1und1.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Stefan Wahren <stefan.wahren@i2se.com> hat am 1. September 2018 um 21:29 geschrieben:
> 
> 
> Since the LAN7515 on Raspberry Pi 3B+ doesn't have an EEPROM and the OTP
> is empty, we need to enable the Ethernet LEDs via Device Tree.
> 
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>

applied to bcm2835-dt-next
