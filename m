From: bgat@billgatliff.com (Bill Gatliff)
Date: Tue, 20 Oct 2009 12:27:03 -0500
Subject: [PATCH] mmc: at91_mci: Don't include asm/mach/mmc.h
In-Reply-To: <4AD42E10.7010801@atmel.com>
References: <1254996762-19115-1-git-send-email-u.kleine-koenig@pengutronix.de>	<1255418388-27866-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<4AD42E10.7010801@atmel.com>
Message-ID: <4ADDF2E7.4010200@billgatliff.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nicolas Ferre wrote:
> Uwe Kleine-K?nig :
>   
>> This fixes a compile error introduced in
>>
>> 	6ef297f (ARM: 5720/1: Move MMCI header to amba include dir)
>>
>> That commit moved arch/arm/include/asm/mach/mmc.h to
>> include/linux/amba/mmci.h.  Just removing the include was enough.
>>
>> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
>> Acked-by: Linus Walleij <linus.walleij@stericsson.com>
>> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
>> Acked-by: Bill Gatliff <bgat@billgatliff.com>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Russell King <rmk+kernel@arm.linux.org.uk>
>> Cc: Pierre Ossman <drzeus@drzeus.cx>
>> Cc: linux-arm-kernel at lists.infradead.org
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> ---
>> Hello,
>>
>> what is the right path to Linus for this patch?
>>     
>
> Uwe,
>
> I gess that Andrew Morton will have to handle it.
>
> Let's help him not forget it ;-)
>   

Indeed!  This one _really_ annoys me.


b.g.

-- 
Bill Gatliff
bgat at billgatliff.com
