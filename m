From: bigeasy@linutronix.de (Sebastian Andrzej Siewior)
Date: Fri, 7 Jan 2011 12:20:10 +0100
Subject: I2C support for CE4100, v3
In-Reply-To: <20110105215159.GU817@trinity.fluff.org>
References: <1294246263-31960-1-git-send-email-bigeasy@linutronix.de>
	<20110105215159.GU817@trinity.fluff.org>
Message-ID: <20110107112010.GA18652@www.tglx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Ben Dooks | 2011-01-05 21:51:59 [+0000]:

>> Sebastian Andrzej Siewior (6):
>>       i2c/pxa: use dynamic register layout
>>       arm/pxa2xx: reorganize I2C files
>>       i2c/pxa2xx: Add PCI support for PXA I2C controller
>>       i2c/pxa2xx: add support for shared IRQ handler
>>       i2c/pxa2xx: check timeout correctly
>>       i2c/pxa2xx: pass of_node from platform driver to adapter and publish
>
>please rename these i2c-pxa2xx
>and for the ARM, use ARM: pxa2xx as the prefix
> 
Done

Sebastian
