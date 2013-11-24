From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 23 Nov 2013 22:05:43 -0500
Subject: [PATCH] ARM: orion5x: drop unused include from common.c
In-Reply-To: <1383557043-18891-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1383557043-18891-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20131124030543.GS29241@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 04, 2013 at 10:24:03AM +0100, Uwe Kleine-K?nig wrote:
> asm/times.h only defines CLOCK_TICK_RATE, cycles_t and get_cycles. All
> three are not used in this file.
> 
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---
>  arch/arm/mach-orion5x/common.c | 1 -
>  1 file changed, 1 deletion(-)

Applied to mvebu/soc with Andrew's Ack.

thx,

Jason.
