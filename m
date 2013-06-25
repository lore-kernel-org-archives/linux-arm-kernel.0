From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 25 Jun 2013 12:34:40 +0200
Subject: [PATCH v4] irqchip: Add support for ARMv7-M's NVIC
In-Reply-To: <1371073835-10639-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1371073835-10639-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20130625103440.GR11232@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Thomas, hello Grant,

On Wed, Jun 12, 2013 at 11:50:35PM +0200, Uwe Kleine-K?nig wrote:
> This interrupt controller is found on Cortex-M3 and Cortex-M4 machines.
> 
> Support for this controller appeared in Catalin's Cortex tree based on
> 2.6.33 but was nearly completely rewritten.
> 
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---
> 
> Notes:
>     Changes since v3, sent with
>     Message-Id: <1366214540-31166-1-git-send-email-u.kleine-koenig@pengutronix.de>:
>     
>      - use generic chip
>      - rename nvic_do_IRQ to nvic_handle_irq
>     
>     This depends on the stuff currently in tip/irq/for-arm
I see that tip/irq/for-arm went into next via Grant's irqdomain tree. I
assume that means the changes go in for 3.11?

Are you OK with my patch? I can resend with the accumulated Acks and the
arch/arm hunk dropped if it helps you. Just tell me what you want.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
