From: stigge@antcom.de (Roland Stigge)
Date: Thu, 19 Apr 2012 19:12:53 +0200
Subject: Defconfig update for LPC32xx
Message-ID: <4F904795.4050505@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I'm planning to update arch/arm/configs/lpc32xx_defconfig, adjusting to
device tree and new driver options.

Now I wonder if I should (1) just add drivers which are used on the
reference machine (PHYTEC LPC3250 board) or (2) additionally add all
drivers that I have seen together with LPC32xx on other boards also,
which would demonstrate that the same binary kernel runs on all LPC32xx
machines, but increasing kernel size a bit.

I would prefer option (2) but first want to ask for advice.

Thanks in advance,

Roland
