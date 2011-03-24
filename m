From: khilman@ti.com (Kevin Hilman)
Date: Thu, 24 Mar 2011 08:27:55 -0700
Subject: [PATCH] OMAP4: PM: Avoid omap4_pm_init() on OMAP4430 ES1.0
In-Reply-To: <1299844601-13248-1-git-send-email-santosh.shilimkar@ti.com>
	(Santosh Shilimkar's message of "Fri, 11 Mar 2011 17:26:41 +0530")
References: <1299844601-13248-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <87fwqc1qtg.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Santosh,

Santosh Shilimkar <santosh.shilimkar@ti.com> writes:

> On OMAP4430 ES1.0, Power Management features are not supported.
> Avoid omap4_pm_init() on ES1.0 silicon so that we can continue
> to use same kernel binary to boot on all OMAP4 silicons.
>
> The ES1.0 boot failure with OMAP4 PM series was because of
> the clockdomain initialisation code. Hardware supervised
> clockdomain mode isn't functional for all clockdomains
> on OMAP4430 ES1.0 silicon so avoid the same.
>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Reported-by: Kevin Hilman <khilman@ti.com>
> Cc: Kevin Hilman <khilman@ti.com>
> ---
> Patch applies on top of OMAP4 PM series

This looks OK.

Please include in the repost of your OMAP4 PM series.

Kevin
