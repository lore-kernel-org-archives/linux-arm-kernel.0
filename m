From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 21 May 2013 11:06:00 +0200
Subject: [PATCH] Change internal SRAM memory type to "MT_MEMORY_SO"
In-Reply-To: <1369011911-21282-1-git-send-email-wenyou.yang@atmel.com>
References: <1369011911-21282-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <519B38F8.1040601@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/05/2013 03:05, Wenyou Yang :
> Hi Russell,

Wenyou, In fact this patch is targeted for myself and not Russell. It 
will join mainline using arm-soc git tree which is managed by Arnd and Olof.

> This patch is to change the internal SRAM memory type to "MT_MEMORY_SO", the right type.
>
> It tested on sama5d3xek boards.
>
> It based on v3.10-rc1.
>
> Best Regards,
> Wenyou Yang
>
> Wenyou Yang (1):
>    ARM: at91: Fix: Change internal SRAM memory type to "MT_MEMORY_SO"
>
>   arch/arm/mach-at91/setup.c |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Bye,
-- 
Nicolas Ferre
