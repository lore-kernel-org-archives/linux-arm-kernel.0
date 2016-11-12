From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Sat, 12 Nov 2016 15:41:31 +0100 (CET)
Subject: [PATCH] ARM64: dts: bcm2837-rpi-3-b: remove incorrect pwr LED
In-Reply-To: <20161111173821.21491-1-eric@anholt.net>
References: <20161111173821.21491-1-eric@anholt.net>
Message-ID: <741880731.428971.a2c5fd60-1b30-481e-b728-fc62c8d1c81a.open-xchange@email.1und1.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eric,

[add Gerd to CC]

> Eric Anholt <eric@anholt.net> hat am 11. November 2016 um 18:38 geschrieben:
> 
> 
> From: Andrea Merello <andrea.merello@gmail.com>
> 
> We are incorrectly defining the pwr LED, attaching it to a gpio line
> that is wired to the Wi-Fi SDIO module (which fails due to this).

i agree with the intention of this patch, but is the upstream kernel really
affected? I can't see any compatible for the Wifi interface.

> 
> The actual power LED is connected to the GPIO expander, which we don't
> expose currently.
> 
> Thanks-to: Eric Anholt <eric@anholt.net> [for clarifying we can't control the
> LED]
> Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
> Signed-off-by: Eric Anholt <eric@anholt.net>

Fixes: 9d56c22a7861 ("ARM: bcm2835: Add devicetree for the Raspberry Pi 3.")

Stefan
