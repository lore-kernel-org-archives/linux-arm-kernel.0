From: bigeasy@linutronix.de (Sebastian Andrzej Siewior)
Date: Mon, 08 Sep 2014 18:45:17 +0200
Subject: [PATCH 11/18] tty: serial: 8250_dma: Add a TX trigger workaround
 for AM33xx
In-Reply-To: <20140908164147.GG3238@atomide.com>
References: <1409943773-7874-1-git-send-email-bigeasy@linutronix.de>
 <1409943773-7874-12-git-send-email-bigeasy@linutronix.de>
 <20140908164147.GG3238@atomide.com>
Message-ID: <540DDD1D.201@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/08/2014 06:41 PM, Tony Lindgren wrote:
> * Sebastian Andrzej Siewior <bigeasy@linutronix.de> [140905 12:28]:
>> This problem has not been seen on DRA7 or beaglebone (OMAP3). I am not
>> sure if this is UART-IP core specific or DMA engine.
> 
> Maybe check this comment for future reference too because
> beaglebone and bealeboard do different things for PM.. Do
> you mean Beaglebone or beagleboard? Or both?

Beagle bone (am335x) has the problem.
Beagle board xm (omap3) does not have the problem.
So let me replace "beaglebone" with "beagle board xm"

> 
> Regards,
> 
> Tony
> 

Sebastian
