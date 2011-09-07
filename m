From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 07 Sep 2011 10:50:25 +0200
Subject: [PATCH] at91/usb: always provide all the clocks
In-Reply-To: <1314667768-14129-1-git-send-email-plagnioj@jcrosoft.com>
References: <1314667768-14129-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <4E673051.2030206@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 30/08/2011 03:29, Jean-Christophe PLAGNIOL-VILLARD :
> drop the cpu_is in the driver
> at91sam9261 and at91sam9g10 expect 3 clocks
> 
> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>

included in at91-l2 branch on:
git://github.com/at91linux/linux-at91.git
(mind the removal of -2.6-)

> ---
>  arch/arm/mach-at91/at91cap9.c    |    2 ++
>  arch/arm/mach-at91/at91rm9200.c  |    2 ++
>  arch/arm/mach-at91/at91sam9260.c |    2 ++
>  arch/arm/mach-at91/at91sam9261.c |   29 +++++++++++++++--------------
>  arch/arm/mach-at91/at91sam9263.c |    2 ++
>  arch/arm/mach-at91/at91sam9g45.c |    2 ++
>  drivers/usb/host/ohci-at91.c     |   15 +++++----------

USB guys,

Are you ok if we send this patch upstream through the ARM soc git tree?

Best regards,
-- 
Nicolas Ferre
