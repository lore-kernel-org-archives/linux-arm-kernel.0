From: tony@atomide.com (Tony Lindgren)
Date: Tue, 12 Apr 2016 14:17:03 -0700
Subject: [PATCH] ARM: dts: am335x-baltos-ir5221: use dedicated RTS/CTS
 signals
In-Reply-To: <1459246088-17768-1-git-send-email-yegorslists@googlemail.com>
References: <1459246088-17768-1-git-send-email-yegorslists@googlemail.com>
Message-ID: <20160412211703.GG5995@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* yegorslists at googlemail.com <yegorslists@googlemail.com> [160329 03:10]:
> From: Yegor Yefremov <yegorslists@googlemail.com>
> 
> Before "tty: Add software emulated RS485 support for 8250" patch Baltos devices
> relied on MCTRL_GPIO framework to handle both modem signals and RS485 mode.
> 
> With emulated RS485 support for 8250 we can now use these pins as dedicated
> RTS/CTS signals taking advantage of hardware flow control etc. when operating
> in RS232 mode.

Applying into omap-for-v4.7/dt thanks.

Tony
