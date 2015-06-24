From: tony@atomide.com (Tony Lindgren)
Date: Wed, 24 Jun 2015 03:54:21 -0700
Subject: [PATCH V2 4/5] drivers/rtc/rtc-ds1307.c: Support optional wakeup
 interrupt source
In-Reply-To: <1435076114-12416-5-git-send-email-nm@ti.com>
References: <1435076114-12416-1-git-send-email-nm@ti.com>
 <1435076114-12416-5-git-send-email-nm@ti.com>
Message-ID: <20150624105421.GD4156@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Nishanth Menon <nm@ti.com> [150623 09:21]:
> With the recent pinctrl-single changes, SoCs such as Texas
> Instrument's OMAP processors can treat wake-up events from deeper idle
> states as interrupts.
> 
> Let's add support for the optional second interrupt for wake-up using
> the generic wakeirq support added in commit 4990d4fe327b ("PM /
> Wakeirq: Add automated device wake IRQ handling")
> 
> Finally, to pass the wake-up interrupt in the dts file,
> interrupts-extended property needs to be passed.
> 
> This is similar in approach to commit 2a0b965cfb6e ("serial: omap: Add
> support for optional wake-up") + ee83bd3b6483 ("serial: omap: Switch
> wake-up interrupt to generic wakeirq")

The wakeirq related changes look good to me:

Acked-by: Tony Lindgren <tony@atomide.com>
