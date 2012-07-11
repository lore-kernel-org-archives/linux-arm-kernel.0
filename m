From: tglx@linutronix.de (Thomas Gleixner)
Date: Wed, 11 Jul 2012 23:10:43 +0200 (CEST)
Subject: [PATCH v5] clocksource: dw_apb_timer: Add common DTS glue for
 dw_apb_timer
In-Reply-To: <1342037596-17710-1-git-send-email-dinguyen@altera.com>
References: <1342037596-17710-1-git-send-email-dinguyen@altera.com>
Message-ID: <alpine.LFD.2.02.1207112307061.32033@ionos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 11 Jul 2012, dinguyen at altera.com wrote:

> From: Dinh Nguyen <dinguyen@altera.com>
> 
> Make a common device tree glue for clocksource/dw_apb_timer.
> Move mach-picoxcell/time.c to be a generic device tree application
> of the dw_apb_timer.
> 
> Configure mach-picoxcell to use the dw_apb_timer_of device tree
> implementation in drivers/clocksource.
> 
> Signed-off-by: Pavel Machek <pavel@denx.de>
> Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
> Acked-by: Jamie Iles <jamie@jamieiles.com>

Acked-by: Thomas Gleixner <tglx@linutronix.de>

Please take it through the proper ARM/SoC tree so work depending on
that does not get blocked.

Thanks,

	tglx
