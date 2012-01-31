From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 31 Jan 2012 20:39:36 +0100
Subject: [RFC PATCH 08/11] Cortex-M3: Add NVIC support
In-Reply-To: <1327230817-12855-8-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20120122111230.GB14835@pengutronix.de>
 <1327230817-12855-8-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20120131193935.GA25594@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Sun, Jan 22, 2012 at 12:13:34PM +0100, Uwe Kleine-K?nig wrote:
> From: Catalin Marinas <catalin.marinas@arm.com>
> 
> This patch implements the NVIC (interrupt controller) support for
> Cortex-M3.
> 
> [ukleinek: use a raw spinlock]
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---
> Actually it should be able to share much code with/use
> arch/arm/common/gic.c, but I didn't manage to get it up.
> 
> My problem is that I need hardware irq 13 but in gic.c hw_irq is set to
> at least 16. I guess I didn't understood something correctly and would
> be glad to get a tip who to fix that.
s/who/how/ of course.

I added a few people to Cc that recently touched arch/arm/common/gic.c.

Can anybody help?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
