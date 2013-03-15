From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 15 Mar 2013 21:57:15 +0000
Subject: [GIT PULL 0/5] Samsung changes-1 for v3.10
In-Reply-To: <016501ce1ada$b8979e60$29c6db20$%kim@samsung.com>
References: <016501ce1ada$b8979e60$29c6db20$%kim@samsung.com>
Message-ID: <201303152157.15580.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 07 March 2013, Kukjin Kim wrote:
> Hi Arnd and Olof,
> 
> Here is 1st Samsung pull-request for v3.10
> 
> This is including cleanup some header files for s3c and s5p, and samsung-timer
> for s3c and s5pc100 to support clocksource/clockevent api, and irq-rework for
> s3cs4xx stuff, and support pinctrl for exynos5250.
> 
> Note, you know, there are some branches in samsung tree I missed to send to
> upstream last time. I'm sorting them out and as I talked to Olof before, I will
> send them in early time.

Pulled all five branches, the first two into next/cleanup and the other three
into next/drivers. Please remember to use signed tags with a series description
next time, since that makes life easier for me filling in a proper merge
changelog.

Regarding the irq-s3c24xx series, I wonder if the irq.c file should now
get moved to drivers/irqchip/irq-s3c24xx.c as a follow-up. Have you considered
that?

	Arnd
