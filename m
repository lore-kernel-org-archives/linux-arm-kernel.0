From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 07 Sep 2011 09:15:31 +0100
Subject: [PATCH] mtd: drop Integrator flash map Kconfig
In-Reply-To: <1315381829-21548-1-git-send-email-linus.walleij@stericsson.com>
References: <1315381829-21548-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <4E672823.4080003@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/09/11 08:50, Linus Walleij wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
> 
> The integrator flash has been deleted, even from the Makefile.
> Drop the Kconfig entry as well.
> 
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

I wonder how I managed to drop that hunk. Oh well...
Thanks for noticing this!

Acked-by: Marc Zyngier <marc.zyngier@arm.com>
-- 
Jazz is not dead. It just smells funny...
