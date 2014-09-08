From: tony@atomide.com (Tony Lindgren)
Date: Mon, 8 Sep 2014 09:41:48 -0700
Subject: [PATCH 11/18] tty: serial: 8250_dma: Add a TX trigger workaround
 for AM33xx
In-Reply-To: <1409943773-7874-12-git-send-email-bigeasy@linutronix.de>
References: <1409943773-7874-1-git-send-email-bigeasy@linutronix.de>
 <1409943773-7874-12-git-send-email-bigeasy@linutronix.de>
Message-ID: <20140908164147.GG3238@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Sebastian Andrzej Siewior <bigeasy@linutronix.de> [140905 12:28]:
> This problem has not been seen on DRA7 or beaglebone (OMAP3). I am not
> sure if this is UART-IP core specific or DMA engine.

Maybe check this comment for future reference too because
beaglebone and bealeboard do different things for PM.. Do
you mean Beaglebone or beagleboard? Or both?

Regards,

Tony
