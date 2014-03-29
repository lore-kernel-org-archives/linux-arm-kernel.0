From: b.brezillon.dev@gmail.com (Boris BREZILLON)
Date: Sat, 29 Mar 2014 11:11:03 +0100
Subject: [RFC PATCH v2 05/10] ARM: at91: make use of the new AIC driver
 for dt enabled boards
In-Reply-To: <20140329100756.272c978d@skate>
References: <1396029548-10928-1-git-send-email-b.brezillon.dev@gmail.com>	<1396029548-10928-6-git-send-email-b.brezillon.dev@gmail.com>
 <20140329100756.272c978d@skate>
Message-ID: <53369C37.4030104@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Thomas,

Le 29/03/2014 10:07, Thomas Petazzoni a ?crit :
> Dear Boris BREZILLON,
>
> On Fri, 28 Mar 2014 18:59:03 +0100, Boris BREZILLON wrote:
>
>> +config ATMEL_AIC_IRQ
>> +	bool
>> +	default USE_OF
>> +	select GENERIC_IRQ_CHIP
>> +	select IRQ_DOMAIN
>> +	select MULTI_IRQ_HANDLER
> This option should probably go in drivers/irqchip/Kconfig, no?

Absolutely, I'll move this section into drivers/irqchip/Kconfig.

Best Regards,

Boris
>
> Thomas
