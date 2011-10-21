From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 21 Oct 2011 09:22:19 +0200
Subject: [PATCH] arm/imx: add missing include of asm/exception.h for avic.c
In-Reply-To: <1319164380-23517-1-git-send-email-shawn.guo@linaro.org>
References: <1319164380-23517-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <20111021072219.GH15299@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,


On Fri, Oct 21, 2011 at 10:33:00AM +0800, Shawn Guo wrote:
> It adds missing include of asm/exception.h for avic.c to fix the
> compile error below.
> 
>   arch/arm/plat-mxc/avic.c:154:39: error: expected ?=?, ?,?, ?;?,
>   ?asm? or ?__attribute__? before ?avic_handle_irq?
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Arnd already posted a patch for that[1], but this one looks better.

Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

[1] http://mid.gmane.org/1928841.IC5oQhqc6l at wuerfel

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
