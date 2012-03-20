From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Tue, 20 Mar 2012 10:36:41 -0700
Subject: [PATCH v2 3/4] drivers: input: Fix OMAP_GPIO_IRQ with
 gpio_to_irq() in ams_delta_serio_exit()
In-Reply-To: <20120320165246.GH9859@atomide.com>
References: <1332158817-26311-1-git-send-email-tarun.kanti@ti.com>
 <1332158817-26311-4-git-send-email-tarun.kanti@ti.com>
 <20120320165246.GH9859@atomide.com>
Message-ID: <20120320173641.GA6464@core.coreip.homeip.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 20, 2012 at 09:52:46AM -0700, Tony Lindgren wrote:
> Hi Dmitry,
> 
> * Tarun Kanti DebBarma <tarun.kanti@ti.com> [120319 05:09]:
> > Even though ams-delta-serio input driver uses gpio_to_irq() in all
> > relevent places to get irq number, the ams_delta_serio_exit() still
> > uses OMAP_GPIO_IRQ macro. Fix this.
> > 
> > Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> 
> Care to ack this one? I'd like to apply all four as fixes
> at the end of the merge window so we can drop the old and
> now broken OMAP_GPIO_IRQ macro.

Sure.

Acked-by: Dmitry Torokhov <dtor@mail.ru>

Thanks.

-- 
Dmitry
