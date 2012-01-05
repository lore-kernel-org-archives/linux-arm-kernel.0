From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 05 Jan 2012 18:50:48 +0100
Subject: [PATCH v3 3/6] ARM: at91/gpio: add DT support
In-Reply-To: <1325792566-32700-1-git-send-email-nicolas.ferre@atmel.com>
References: <1325615688-16860-1-git-send-email-nicolas.ferre@atmel.com>
 <1325792566-32700-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <4F05E2F8.2020609@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/05/2012 08:42 PM, Nicolas Ferre :
> From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> 
> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> Acked-by: Grant Likely <grant.likely@secretlab.ca>
> ---
> v3: - Corrections proposed by Russell King:
>       - use of clk_prepare()/clk_unprepare()
>       - helper function to setup the clock for both DT/non DT init functions

Forget this one: a bug has made its home in it...

> v2: - no BUG_ON() anymore in case of an "interrupts" property missing
>       just stop configuring the gpio bank
>     - review error path in both of_at91_gpio_init_one() and
>       at91_gpio_init_one()
>     - use for_each_compatible_node() iterator instead of a homemade loop

[..]
-- 
Nicolas Ferre
