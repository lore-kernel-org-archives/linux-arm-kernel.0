From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 5 Nov 2014 18:13:25 +0100
Subject: [PATCH 0/2] clk: at91: usb: rate calculation fixes
In-Reply-To: <1415179995-25062-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1415179995-25062-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <545A5AB5.2040805@atmel.com>
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

Can you give us a hint about the "stable tag" that would be good to add?

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
