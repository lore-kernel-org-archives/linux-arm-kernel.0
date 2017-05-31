From: tony@atomide.com (Tony Lindgren)
Date: Wed, 31 May 2017 10:19:32 -0700
Subject: [PATCH RFC 2/5] ARM: dts: am335x-baltos: use IRQ_TYPE_* to
 specify irq flags
In-Reply-To: <20170526180609.2699-2-uwe@kleine-koenig.org>
References: <20170526180609.2699-1-uwe@kleine-koenig.org>
 <20170526180609.2699-2-uwe@kleine-koenig.org>
Message-ID: <20170531171932.GH3730@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Uwe Kleine-K?nig <uwe@kleine-koenig.org> [170526 11:09]:
> According to the binding documentation and the source code the omap-gpio
> controller takes IRQ_TYPE_* as its flags values, not GPIO_ACTIVE_*.
> 
> This patch uses the right variable type which yields the same result
> when compiled. Note that this might be wrong and actually
> IRQ_TYPE_LEVEL_LOW is intended by the dt author.
> 
> Signed-off-by: Uwe Kleine-K?nig <uwe@kleine-koenig.org>
> ---
> Hello,
> 
> can somebody with the hardware or it's documentation please check which
> flag is the right one?

I'll wait on this one until we have somebody test it.

Regards,

Tony
