From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 13 Nov 2014 11:59:35 +0100
Subject: [PATCH 0/2] clk: at91: usb: rate calculation fixes
In-Reply-To: <1415179995-25062-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1415179995-25062-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <54648F17.6030601@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/11/2014 10:33, Boris Brezillon :
> Hello,
> 
> Here are a few more fixes for the at91 usb clk driver.
> 
> These bugs are related to rate calculation, and have been reported by
> Andreas.
> 
> As this is not my first mistake in this rate calculation algorithm, I'd
> really like to have reviews/feedback on this fixes to avoid potential
> regressions.
> 
> Mike, when/if we agree on these fixes, can we make them go into one of
> the 3.18-rc cycle ?

With Alex modifications, you can add my:

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

To your next series.

Bye,


> Boris Brezillon (2):
>   clk: at91: usb: fix at91rm9200 round and set rate
>   clk: at91: usb: fix at91sam9x5 recalc, round and set rate
> 
>  drivers/clk/at91/clk-usb.c | 35 ++++++++++++++++++++---------------
>  1 file changed, 20 insertions(+), 15 deletions(-)
> 


-- 
Nicolas Ferre
