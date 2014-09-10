From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 10 Sep 2014 11:17:43 -0400
Subject: [PATCH 2/3] ARM: make of_device_ids const
In-Reply-To: <1410337579-23466-3-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1410337579-23466-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1410337579-23466-3-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20140910151743.GW30828@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Uwe,

On Wed, Sep 10, 2014 at 10:26:18AM +0200, Uwe Kleine-K?nig wrote:
> of_device_ids (i.e. compatible strings and the respective data) are not
> supposed to change at runtime. All functions working with of_device_ids
> provided by <linux/of.h> work with const of_device_ids. So mark the
> non-const structs in arch/arm as const, too.
> 
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---
...
>  arch/arm/mach-mvebu/coherency.c          | 2 +-
>  arch/arm/mach-mvebu/pmsu.c               | 2 +-

For the mvebu stuff,

Acked-by: Jason Cooper <jason@lakedameon.net>

thx,

Jason.
